import {resolve} from "path";
import {defineConfig} from "vite"
import vue from "@vitejs/plugin-vue"
import autoImport from "unplugin-auto-import/vite"
import components from "unplugin-vue-components/vite"
import DefineOptions from "unplugin-vue-define-options/vite"
import {VarletUIResolver} from "unplugin-vue-components/resolvers"

export default defineConfig({
  plugins: [
    vue(),
    DefineOptions(),
    components({
      resolvers: [VarletUIResolver()]
    }),
    autoImport({
      resolvers: [VarletUIResolver({autoImport: true})]
    })
  ],
  resolve: {
    alias: {
      "@": resolve(__dirname, "src")
    }
  },
  css: {
    preprocessorOptions: {
      less: {
        additionalData: `@import "${resolve(__dirname, "src/assets/styles/base.less")}";`,
        javascriptEnabled: true,
        math: "always"
      }
    }
  }
})
