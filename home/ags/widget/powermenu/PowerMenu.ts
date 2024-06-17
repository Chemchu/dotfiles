import PopupWindow from "widget/PopupWindow"
import powermenu, { type Action } from "service/powermenu"
import icons from "lib/icons"
import options from "options"
import type Gtk from "gi://Gtk?version=3.0"

const { layout, labels } = options.powermenu

const SysButton = (action: Action, label: string) => Widget.Button({
    on_clicked: () => powermenu.action(action),
    child: Widget.Box({
        vertical: true,
        class_name: "system-button",
        children: [
            Widget.Icon(icons.powermenu[action]),
            Widget.Label({
                label,
                visible: labels.bind(),
            }),
        ],
    }),
})

export default () => PopupWindow({
    name: "powermenu",
    transition: "crossfade",
    child: Widget.Box<Gtk.Widget>({
        class_name: "powermenu horizontal",
        setup: self => self.hook(layout, () => {
            self.toggleClassName("box", layout.value === "box")
            self.toggleClassName("line", layout.value === "line")
        }),
        children: layout.bind().as(layout => {
            switch (layout) {
                case "line": return [
                    SysButton("shutdown", "Apagar"),
                    SysButton("logout", "Cerrar sesión"),
                    SysButton("reboot", "Reiniciar"),
                    SysButton("sleep", "Hibernar"),
                ]
                case "box": return [
                    Widget.Box(
                        { vertical: true },
                        SysButton("shutdown", "Apagar"),
                        SysButton("logout", "Cerrar sesión"),
                    ),
                    Widget.Box(
                        { vertical: true },
                        SysButton("reboot", "Reiniciar"),
                        SysButton("sleep", "Hibernar"),
                    ),
                ]
            }
        }),
    }),
})
