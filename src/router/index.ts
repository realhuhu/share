import {createRouter, createWebHistory, RouteRecordRaw} from "vue-router"
import {UseStore} from "@/store";

const routes: Array<RouteRecordRaw> = [
  {
    path: "/",
    redirect: "/home"
  },
  {
    path: "/home",
    name: "HomePage",
    component: () => import("@/views/HomePage.vue"),
    meta: {
      depth: 0,
      keep_alive: true
    },
    children: [
      {
        path: "/home",
        redirect: "/home/resource"
      },
      {
        path: "resource",
        name: "HomeResource",
        component: () => import("@/components/home/HomeResource.vue"),
        meta: {
          depth: 0,
          navbar_active: 0
        }
      },
      {
        path: "reward",
        name: "HomeReward",
        component: () => import("@/components/home/HomeReward.vue"),
        meta: {
          depth: 0,
          navbar_active: 1
        }
      },
      {
        path: "favorite",
        name: "HomeFavorite",
        component: () => import("@/components/home/HomeFavorite.vue"),
        meta: {
          depth: 0,
          auth: true,
          navbar_active: 2
        }
      },
      {
        path: "profile",
        name: "HomeProfile",
        component: () => import("@/components/home/HomeProfile.vue"),
        meta: {
          depth: 0,
          navbar_active: 3
        }
      }
    ]
  },
  {
    path: "/search",
    name: "MainSearch",
    component: () => import("@/views/MainSearch.vue"),
    meta: {
      depth: 1
    }
  },
  {
    path: "/create-eth-account",
    name: "CreateEthAccount",
    component: () => import("@/views/CreateEthAccount.vue"),
    meta: {
      depth: 2
    }
  },
  {
    path: "/self-info",
    name: "SelfInfo",
    component: () => import("@/views/SelfInfo.vue"),
    meta: {
      depth: 2,
      auth: true
    }
  },
  {
    path: "/upload",
    name: "UploadFileOrReward",
    component: () => import("@/views/UploadFileOrReward.vue"),
    meta: {
      depth: 99,
      auth: true
    }
  },
  {
    path: "/self-upload",
    name: "SelfUpload",
    component: () => import("@/views/SelfUpload.vue"),
    meta: {
      depth: 2,
      auth: true,
      keep_alive: true
    }
  },
  {
    path: "/self-reward",
    name: "SelfReward",
    component: () => import("@/views/SelfReward.vue"),
    meta: {
      depth: 2,
      auth: true,
      keep_alive: true
    }
  },
  {
    path: "/file-detail/:file_address",
    name: "FileDetail",
    component: () => import("@/views/FileDetail.vue"),
    meta: {
      depth: 4,
      keep_alive: true
    }
  },
  {
    path: "/reward-detail/:reward_address",
    name: "RewardDetail",
    component: () => import("@/views/RewardDetail.vue"),
    meta: {
      depth: 3,
      keep_alive: true
    }
  },
  {
    path: "/follow/:type",
    name: "FollowerAndFollowing",
    component: () => import("@/views/FollowerAndFollowing.vue"),
    meta: {
      depth: 1,
      auth: true,
      keep_alive: true
    }
  },
  {
    path: "/user/:user_address",
    name: "UserInfo",
    component: () => import("@/views/UserInfo.vue"),
    meta: {
      depth: 5,
      auth: true,
      keep_alive: true
    }
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

router.beforeEach((to, from, next) => {
  const store = UseStore()

  if (!store.contracts_connected) {
    const inter = setInterval(async () => {
      if (store.contracts_connected) {
        if (to.meta.auth && !(<any>store).user.is_registered) {
          (<any>store).show_register_modal = true
          next(`/?next=${to.path}`)
        } else {
          next()
        }
        clearInterval(inter)
      }
    }, 50)
  } else {
    if (to.meta.auth && !store.user.is_registered) {
      store.show_register_modal = true
      next(`${from.path}?next=${to.path}`)
    } else {
      next()
    }
  }
})

export const safeBack = function (path: string) {
  return !window.history.state.back && path ? router.replace(path || "/") : router.back()
}


export default router
