import { fetchNui } from "./fetchNui.js";
import { switchClick } from "./main.js";

const optionsWrapper = document.getElementById("options-wrapper");
const itemsPerPage = 10;
let scrollIndex = 0;

function onClick() {
    this.style.pointerEvents = "none";

    fetchNui("select", [this.targetType, this.targetId, this.zoneId]);
    setTimeout(() => (this.style.pointerEvents = "auto"), 100);
    switchClick(false);
}

export function createOptions(type, data, id, zoneId) {
    if (data.hide) return;

    const option = document.createElement("div");
    const iconElement = `<i class="fa-fw ${data.icon} option-icon" ${data.iconColor ? `style = color:${data.iconColor} !important` : null
        }"></i>`;

    option.innerHTML = `${iconElement}<p class="option-label">${data.label}</p>`;
    option.className = "gradient";
    option.targetType = type;
    option.targetId = id;
    option.zoneId = zoneId;

    option.addEventListener("click", onClick);
    optionsWrapper.appendChild(option);
    checkScroll();
}

function checkScroll() {
    const totalOptions = optionsWrapper.children.length;

    if (totalOptions > itemsPerPage) {
        updateOptionsDisplay();
    }
}

function updateOptionsDisplay() {
    const totalOptions = optionsWrapper.children.length;

    for (let i = 0; i < totalOptions; i++) {
        optionsWrapper.children[i].style.display = "none";
    }

    for (let i = scrollIndex; i < scrollIndex + itemsPerPage && i < totalOptions; i++) {
        optionsWrapper.children[i].style.display = "flex";
    }
}

optionsWrapper.addEventListener("wheel", (event) => {
    event.preventDefault();

    const totalOptions = optionsWrapper.children.length;

    if (event.deltaY < 0 && scrollIndex > 0) {
        scrollIndex--;
        updateOptionsDisplay();
    } else if (event.deltaY > 0 && scrollIndex + itemsPerPage < totalOptions) {
        scrollIndex++;
        updateOptionsDisplay();
    }
});
