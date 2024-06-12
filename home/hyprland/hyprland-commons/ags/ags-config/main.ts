import { Bar } from "src/bar/main"
import { Calendar } from "src/calendar/main"

App.config({
    style: "./style.css",
    windows: [
        Bar(),
        Calendar(),
    ],
})
