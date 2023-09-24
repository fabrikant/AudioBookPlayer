var urlParams = new URLSearchParams(window.location.search);

for (size_grip of document.getElementsByClassName("size-grip")) {
    size_grip.addEventListener("mousedown", event => {
    if (event.button == 0)
        pywebview.api.resize_drag(event.target.dataset.place)
    })
}

document.getElementById("top-bar").addEventListener("mousedown", event => {
    if (event.button == 0) {
        if (!["top-bar", "logo"].includes(event.target.id))
            return
        pywebview.api.drag_window()
    }
})

function getHttpRequestObject()
{
    // Define and initialize as false
    var xmlHttpRequst = false;

    // Mozilla/Safari/Non-IE
    if (window.XMLHttpRequest)
    {
      xmlHttpRequst = new XMLHttpRequest();
    }
    // IE
    else if (window.ActiveXObject)
    {
      xmlHttpRequst = new ActiveXObject("Microsoft.XMLHTTP");
    }
    return xmlHttpRequst;
}

sideMenu = document.getElementById("side-menu")
var menu_opened = true
function toggleMenu() {
    if (menu_opened)
        sideMenu.classList.add("collapsed")
    else
        sideMenu.classList.remove("collapsed")
    menu_opened = !menu_opened
}

var current_page = null
class Page {
    constructor(el) {
        this.el = el
        this.shown = false
        this.onShow = null
        this.onHide = null
        this.hide()
    }
    show() {
        if (current_page) current_page.hide()
        current_page = this
        this.el.style = "display: block"
        this.shown = true
        if (this.onShow) this.onShow(this.el)
        addUrlParams({"page": this.el.id})
    }
    hide() {
        this.el.style = "display: none"
        this.shown = false
        if (this.onHide) this.onHide(this.el)
    }
}

var pages = {}
for (page_el of document.getElementsByClassName("page")) {
    pages[page_el.id] = new Page(page_el)
}
function page(el_id) {return pages[el_id]}

function addUrlParams(params) {
    var refresh = window.location.protocol + "//" + window.location.host + "?";
    for ([name, value] of Object.entries(params)) {
        urlParams.set(name, value)
    }
    urlParams.forEach((v, k) => {
        refresh = refresh + `${k}=${v}&`
    })
    window.history.pushState({path: refresh}, '', refresh)
}

function parseUrlParams() {
    page_name = urlParams.get("page")
    if (page_name) {
        page_obj = page(page_name)
        if (page_obj) {
            page_obj.show()
            return
        }
    }
    page("search-page").show()
}
window.addEventListener("pywebviewready", parseUrlParams)

function delay(time) {
    return new Promise(resolve => setTimeout(resolve, time));
}
