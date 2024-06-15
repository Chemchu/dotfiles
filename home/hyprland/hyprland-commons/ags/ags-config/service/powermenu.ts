import options from "options"

const { sleep, reboot, logout, shutdown } = options.powermenu

export type Action = "sleep" | "reboot" | "logout" | "shutdown"

class PowerMenu extends Service {
    static {
        Service.register(this, {}, {
            "title": ["string"],
            "cmd": ["string"],
        })
    }

    #title = ""
    #cmd = ""

    get title() { return this.#title }

    action(action: Action) {
        [this.#cmd, this.#title] = {
            sleep: [sleep.value, "Hibernar"],
            reboot: [reboot.value, "Reiniciar"],
            logout: [logout.value, "Cerrar sesión"],
            shutdown: [shutdown.value, "Apagar"],
        }[action]

        this.notify("cmd")
        this.notify("title")
        this.emit("changed")
        App.closeWindow("powermenu")
        App.openWindow("verification")
    }

    readonly shutdown = () => {
        this.action("shutdown")
    }

    readonly exec = () => {
        App.closeWindow("verification")
        Utils.exec(this.#cmd)
    }
}

const powermenu = new PowerMenu
Object.assign(globalThis, { powermenu })
export default powermenu
