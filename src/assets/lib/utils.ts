import {Snackbar} from "@varlet/ui";
import "@varlet/ui/es/snackbar/style/index"
import {experience_list} from "@/assets/lib/settings";
import Identicon from "identicon.js";
import {BigNumber, ContractTransaction, ethers} from "ethers";

export const TODO = (msg: string) => {
  Snackbar({
    content: msg,
    type: "info",
    duration: 2000
  })
}
export const assertNotEmpty = <T>(data: T | null | undefined, message: string): T => {
  if (data) return data
  Snackbar({
    duration: 1000,
    type: "error",
    content: message
  })
  throw Error(message)
}

export const stripAddress = (address: string): string => {
  return address.substr(0, 5) + "..." + address.substr(38);
}

export const calcLevel = (experience: number) => {
  let level = 0
  let total = 0
  for (let i = 0; i < experience_list.length; i++) {
    if (experience >= experience_list[i]) {
      total = experience_list[i + 1] || experience_list[i]
      level++
    }
  }

  return {level, experience, total}
}

export class DateParser {
  date

  constructor(raw_data: Nullable<number | string> = null) {
    if (typeof raw_data === "number" && raw_data < 1e12) {
      raw_data *= 1e3
    }
    this.date = raw_data ? new Date(raw_data) : new Date()
  }

  seconds() {
    return this.date.getSeconds()
  }

  hours() {
    return this.date.getHours()
  }

  minutes() {
    return this.date.getMinutes()
  }

  day() {
    return this.date.getDate()
  }

  month() {
    return this.date.getMonth() + 1
  }

  year() {
    return this.date.getFullYear()
  }

  //16:25
  hoursMinutes() {
    return this.hours().toString().padStart(2, "0") + ":" + this.minutes().toString().padStart(2, "0")
  }

  //10-21
  monthDay() {
    return this.month().toString().padStart(2, "0") + "-" + this.day().toString().padStart(2, "0")
  }

  //10-21 16:25
  monthDayHoursMinutes() {
    return this.monthDay() + " " + this.hoursMinutes()
  }

  //2021-10-21
  yearMonthDay() {
    return this.year() + "-" + this.monthDay()
  }

  all() {
    return this.yearMonthDay() + " " + this.hoursMinutes()
  }
}

export const dateDelta = (value: number) => {
  const nowDate = new DateParser()
  const valueDate = new DateParser(value)
  let str = ""
  if (nowDate.date > valueDate.date) {
    if (nowDate.year() > valueDate.year()) str += nowDate.year() - valueDate.year() + "年"
    if (nowDate.month() > valueDate.month()) str += nowDate.month() - valueDate.month() + "月"
    if (nowDate.day() > valueDate.day()) str += nowDate.day() - valueDate.day() + "天"
    if (nowDate.hours() > valueDate.hours()) str += nowDate.hours() - valueDate.hours() + "小时"
    if (nowDate.minutes() > valueDate.minutes()) str += nowDate.minutes() - valueDate.minutes() + "分钟"
  } else {
    if (nowDate.year() < valueDate.year()) str += valueDate.year() - nowDate.year() + "年"
    if (nowDate.month() < valueDate.month()) str += valueDate.month() - nowDate.month() + "月"
    if (nowDate.day() < valueDate.day()) str += valueDate.day() - nowDate.day() + "天"
    if (nowDate.hours() < valueDate.hours()) str += valueDate.hours() - nowDate.hours() + "小时"
    if (nowDate.minutes() < valueDate.minutes()) str += valueDate.minutes() - nowDate.minutes() + "分钟"
  }
  return str
}
export const datetime = (value: number) => {
  const nowDate = new DateParser()
  const valueDate = new DateParser(value)
  if (nowDate.year() > valueDate.year()) return valueDate.yearMonthDay()
  if (nowDate.monthDay() > valueDate.monthDay()) return valueDate.monthDay() + " " + valueDate.hoursMinutes()
  if (nowDate.hours() > valueDate.hours()) return `${nowDate.hours() - valueDate.hours()}小时前`
  if (nowDate.minutes() > valueDate.minutes()) return `${nowDate.minutes() - valueDate.minutes()}分钟前`
  if (nowDate.seconds() > valueDate.seconds()) return `${nowDate.seconds() - valueDate.seconds()}秒前`
  return "刚刚"
}

export const avatar = (str: string) => {
  return "data:image/png;base64," + new Identicon(ethers.utils.hashMessage(str), {margin: 0.2}).toString()
}

export const wait = async (func: Promise<ContractTransaction>) => {
  const res = await func
  Snackbar({
    content: "处理中...",
    type: "success"
  })
  try {
    await res.wait()
    Snackbar({
      content: "已完成",
      type: "success"
    })
    return true
  } catch (e) {
    const err = <MetaMaskError>e
    console.error(err.message);
    switch (err.code) {
      default:
        Snackbar({
          content: "频率过快，请重试",
          type: "error"
        })
    }
    return false
  }
}
export const upAndDownCallback = <T extends {
  up_and_down: BigNumber,
  up_num: BigNumber,
  down_num: BigNumber
}>(meta: T, is_up: boolean): T => {
  meta = {...meta}
  if (meta.up_and_down.toNumber() === 0) {//未操作
    if (is_up) {
      meta.up_num = BigNumber.from(meta.up_num.toNumber() + 1);
      meta.up_and_down = BigNumber.from(1);
    } else {
      meta.down_num = BigNumber.from(meta.down_num.toNumber() + 1);
      meta.up_and_down = BigNumber.from(2);
    }
  } else if (meta.up_and_down.toNumber() === 1) {//已点赞
    if (is_up) {
      meta.up_num = BigNumber.from(meta.up_num.toNumber() - 1);
      meta.up_and_down = BigNumber.from(0);
    } else {
      meta.up_num = BigNumber.from(meta.up_num.toNumber() - 1);
      meta.down_num = BigNumber.from(meta.down_num.toNumber() + 1);
      meta.up_and_down = BigNumber.from(2);
    }
  } else if (meta.up_and_down.toNumber() === 2) {//已点踩
    if (is_up) {
      meta.up_num = BigNumber.from(meta.up_num.toNumber() + 1);
      meta.down_num = BigNumber.from(meta.down_num.toNumber() - 1);
      meta.up_and_down = BigNumber.from(1);
    } else {
      meta.down_num = BigNumber.from(meta.down_num.toNumber() - 1);
      meta.up_and_down = BigNumber.from(0);
    }
  }
  return meta
}

export const markCallback = <T extends { mark_num: BigNumber, is_mark: boolean }>(meta: T) => {
  meta = {...meta}
  if (meta.is_mark) {
    meta.mark_num = BigNumber.from(meta.mark_num.toNumber() - 1)
  } else {
    meta.mark_num = BigNumber.from(meta.mark_num.toNumber() + 1)
  }
  meta.is_mark = !meta.is_mark
  return meta
}

export const followCallback = <T extends { is_following: boolean }>(meta: T) => {
  meta = {...meta}
  meta.is_following = !meta.is_following
  return meta
}

