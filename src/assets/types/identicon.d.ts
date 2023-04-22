declare module "identicon.js" {
  type IdenticonOption = {
    background?: number[4],
    margin?: number,
    size?: number,
    saturation?: number,
    brightness?: number,
  }

  class Identicon {
    constructor(hash: string, option?: IdenticonOption)

    toString(): string
  }

  export default Identicon
}
