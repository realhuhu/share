export {}

declare module "vue-router" {
  interface RouteMeta {
    login?: boolean,
    depth: number
  }
}
