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
        path: "",
        redirect: "/home/resource"
      },
      {
        path: "resource",
        name: "resource",
        component: () => import("@/components/home/HomeResource.vue"),
        meta: {
          navbar_active: 0
        }
      },
      {
        path: "reward",
        name: "reward",
        component: () => import("@/components/home/HomeReward.vue"),
        meta: {
          navbar_active: 1
        }
      },
      {
        path: "favorite",
        name: "favorite",
        component: () => import("@/components/home/HomeFavorite.vue"),
        meta: {
          navbar_active: 2
        }
      },
      {
        path: "profile",
        name: "profile",
        component: () => import("@/components/home/HomeProfile.vue"),
        meta: {
          navbar_active: 3
        }
      }
    ]
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
