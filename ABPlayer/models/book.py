import os
from dataclasses import dataclass, field
from datetime import datetime
from enum import Enum

from orjson import orjson


DATETIME_FORMAT = "%Y-%m-%d %H:%M:%S"


@dataclass
class BookItem:
    """
    Глава книги.
    """

    file_url: str  # Ссылка на файл, для скачивания
    file_index: int  # Номер файла(Нумерация с единицы)
    title: str  # Название главы
    start_time: int  # Время (в секундах), когда начинается глава
    end_time: int  # Время (в секундах), когда заканчивается глава

    @property
    def duration(self) -> int:
        return self.end_time - self.start_time


class BookItems(list):
    """
    Список глав.
    В Базе данных храниться как список словарей.
    """

    def __init__(self, items: list[BookItem | dict[str, str | int]] = ()):
        super().__init__(
            BookItem(**item) if isinstance(BookItem, dict) else item for item in items
        )

    def __getitem__(self, item) -> BookItem:
        return super().__getitem__(item)


class Status(Enum):
    """
    Статус книги.
    """

    NEW = "new"  # Новая книга
    STARTED = "started"  # Начал слушать
    FINISHED = "finished"  # Закончил слушать


@dataclass
class StopFlag:
    """
    Отметка, на которой пользователь остановил прослушивание.
    В базе данных храниться как словарь.
    """

    item: int = 0  # Глава(Индекс)
    time: int = 0  # Секунда


class BookFiles(dict):
    """
    Аудио файлы книги. Словарь: dict[str, str] {<имя файла>: <хеш>}
    """


@dataclass
class Book:
    """
    Класс, описывающий, как книги, хранятся в базе данных,
    а так же какие данные драйвера парсят с сайтов.
    """

    id: int | None = None
    author: str = ""
    name: str = ""
    series_name: str = ""
    number_in_series: int | float | str = ""
    description: str = ""  # Описание
    reader: str = ""  # Чтец
    duration: str = ""  # Длительность
    url: str = ""  # Ссылка на книгу
    preview: str = ""  # Ссылка на превью(обложку) книги
    driver: str = ""  # Драйвер, с которым работает сайт
    items: BookItems = field(default_factory=BookItems)  # Список глав
    status: Status = Status.NEW
    stop_flag: StopFlag = field(default_factory=StopFlag)
    favorite: bool = False
    files: BookFiles = field(default_factory=BookFiles)
    adding_date: datetime = field(default=datetime(2007, 5, 23))
    abp_file_path: str = ""

    @property
    def book_path(self) -> str:
        """
        :return: Относительный путь к книге в библиотеке.
        """
        if self.series_name:
            return os.path.join(
                "./",
                self.author,
                self.series_name,
                f"{self.number_in_series.rjust(2, '0')}. {self.name}",
            )
        return os.path.join("./", self.author, self.name)

    @property
    def dir_path(self) -> str:
        """
        :return: Абсолютный путь к директории, в которой храниться книга.
        """
        return os.path.abspath(os.path.join(os.environ["books_folder"], self.book_path))

    @property
    def listening_progress(self):
        """
        :return: Прогресс прослушивания. (В процентах)
        """
        total = sum([item.duration for item in self.items])
        if not total:
            return "0%"
        cur = (
            sum(
                [
                    item.duration
                    for i, item in enumerate(self.items)
                    if i < self.stop_flag.item
                ]
            )
            + self.stop_flag.time
        )
        return f"{int(round(cur / (total / 100)))}%"

    @classmethod
    def load_from_storage(cls, file_path: str) -> dict:
        with open(file_path, "rb") as file:
            data = dict(**orjson.loads(file.read()), file_path=file_path)
        data["items"] = BookItems(data["items"])
        data["stop_flag"] = StopFlag(**data["stop_flag"])
        data["files"] = BookFiles(data["files"])
        data["adding_date"] = datetime.strptime(data["adding_date"], DATETIME_FORMAT)
        return data

    def save_to_storage(self) -> None:
        with open(self.abp_file_path, "wb") as file:
            file.write(
                orjson.dumps(
                    dict(
                        author=self.author,
                        name=self.name,
                        series_name=self.series_name,
                        number_in_series=self.number_in_series,
                        description=self.description,
                        reader=self.reader,
                        duration=self.duration,
                        url=self.url,
                        preview=self.preview,
                        driver=self.driver,
                        items=self.items,
                        status=self.status,
                        stop_flag=self.stop_flag,
                        favorite=self.favorite,
                        files=self.files,
                        adding_date=self.adding_date.strftime(DATETIME_FORMAT),
                    )
                )
            )

    def __repr__(self):
        return f"Books(id={self.id}, name={self.name}, url={self.url})"


__all__ = [
    "BookItem",
    "BookItems",
    "Status",
    "StopFlag",
    "BookFiles",
    "Book",
    "DATETIME_FORMAT",
]
