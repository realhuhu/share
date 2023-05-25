import {createRouter, createWebHistory, RouteRecordRaw} from "vue-router"

const routes: Array<RouteRecordRaw> = [
  {
    path: "/",
    redirect: "/home"
  },
  {
    path: "/home",
    name: "home",
    component: () => import("@/views/HomePage.vue"),
    children: [
      {
        path: "/home",
        redirect: "/home/resource"
      },
      {
        path: "resource",
        name: "resource",
        component: () => import("@/components/home/HomeResource.vue"),
        meta: {
          depth: 0,
          auth: true,
          navbar_active: 0
        }
      },
      {
        path: "reward",
        name: "reward",
        component: () => import("@/components/home/HomeReward.vue"),
        meta: {
          depth: 0,
          auth: true,
          navbar_active: 1
        }
      },
      {
        path: "favorite",
        name: "favorite",
        component: () => import("@/components/home/HomeFavorite.vue"),
        meta: {
          depth: 0,
          auth: true,
          navbar_active: 2
        }
      },
      {
        path: "profile",
        name: "profile",
        component: () => import("@/components/home/HomeProfile.vue"),
        meta: {
          depth: 0,
          auth: true,
          navbar_active: 3
        }
      }
    ]
  },
  {
    path: "/search",
    name: "search",
    component: () => import("@/views/MainSearch.vue"),
    meta: {
      depth: 1
    }
  },
  {
    path: "/create-eth-account",
    name: "create-eth-account",
    component: () => import("@/views/CreateEthAccount.vue"),
    meta: {
      depth: 2
    }
  },
  {
    path: "/self-info",
    name: "self-info",
    component: () => import("@/views/SelfInfo.vue"),
    meta: {
      depth: 2,
      auth: true
    }
  },
  {
    path: "/upload-file",
    name: "upload-file",
    component: () => import("@/views/UploadFile.vue"),
    meta: {
      depth: 99,
      auth: true
    }
  },
  {
    path: "/self-upload",
    name: "self-upload",
    component: () => import("@/views/SelfUpload.vue"),
    meta: {
      depth: 2,
      auth: true
    }
  },
  {
    path: "/file-detail/:file_address",
    name: "file-detail",
    component: () => import("@/views/FileDetail.vue"),
    meta: {
      depth: 3,
      auth: true
    }
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export const safeBack = function (path: string) {
  return !window.history.state.back && path ? router.replace(path || "/") : router.back()
}


export default router
