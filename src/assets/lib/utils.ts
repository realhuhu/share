export const flat = async <T, R>(promise: Promise<T>): Promise<{
  res: T,
  err: null
} | {
  res: null,
  err: R
}> => new Promise(resolve => {
  promise.then(res => resolve({res, err: null})).catch(err => resolve({res: null, err}))
})

export const stripAddress = (address: Address): string => {
  return address.substr(0, 5) + "..." + address.substr(38);
}
