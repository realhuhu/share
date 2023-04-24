import {createApp} from "vue"
import App from "./App.vue"
import router from "./router"
import {createPinia} from "pinia"
// import piniaPersist from "pinia-plugin-persist"
import "@/assets/styles/tailwind.less"
import "@/assets/styles/transition.less"
import "animate.css"

const pinia = createPinia()
// pinia.use(piniaPersist)

const app = createApp(App)
app.use(router)
app.use(pinia)
app.mount("#app")

import "default-passive-events"
