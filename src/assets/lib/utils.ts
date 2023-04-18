import {Snackbar} from "@varlet/ui";
import "@varlet/ui/es/snackbar/style/index"

export const assertNotEmpty = <T>(data: T|null|undefined, message: string): T => {
  if (data) return data
  Snackbar({
    duration: 1000,
    type: "error",
    content: message
  })
  throw Error(message)
}

export const stripAddress = (address: Address): string => {
  return address.substr(0, 5) + "..." + address.substr(38);
}
