import {createApp} from "vue"
import App from "./App.vue"
import router from "./router"
import {createPinia} from "pinia"
import "@/assets/styles/tailwind.less"
import "@/assets/styles/transition.less"
import "animate.css"

const app = createApp(App)
app.use(router)
app.use(createPinia())
app.mount("#app")

import "default-passive-events"
