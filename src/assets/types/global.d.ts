export {}

declare global {
  type Nullable<T> = T | null
  type PageAnimation = Nullable<"switch-left" | "switch-right" | "scale-pop" | "scale-push">
}
