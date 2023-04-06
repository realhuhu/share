export {}

declare global {
  type Nullable<T> = T | null
  type PageAnimation = Nullable<"switch-left" | "switch-right" | "scale-pop" | "scale-push">
  type HomePagePath = "/home/resource" | "/home/reward" | "/home/favorite" | "/home/profile"
}
