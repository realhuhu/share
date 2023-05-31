export {}

declare module "vue-router" {
  interface RouteMeta {
    auth?: boolean,
    depth: number
    keep_alive?: boolean
  }
}
