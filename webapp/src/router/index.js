import Vue from 'vue';
import VueRouter from 'vue-router';
import Home from '../views/Home.vue';
import Sale from '../views/Sale.vue';
import Purchase from '../views/Purchase.vue'
import Product from '../views/Product.vue';
import Login from '../views/Login.vue';
import userStore from '../store/modules/user';

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    redirect: '/login'
  },
  {
    path: '/login',
    name: 'Login',
    component: Login
  },
  {
    path: '/home',
    name: 'Home',
    component: Home,
    meta: { requiresAuth: true } // expect an object - use meta in protected route
  },
  {
    path: '/purchases',
    name: 'Purchases',
    component: Purchase,
    meta: { requiresAuth: true }
  },
  {
    path: '/sales',
    name: 'Sales',
    component: Sale,
    meta: { requiresAuth: true }
  },
  {
    path: '/products',
    name: 'Products',
    component: Product,
    meta: { requiresAuth: true }
  },
  {
    path: '/history',
    name: 'History',
    component: () => import(/* webpackChunkName: "about" */ '../views/History.vue')
  },
  {
    path: '/404',
    alias: '*',
    name: 'notfound',
    component: () => import(/* webpackChunkName: "NotFound"*/ '../views/NotFound')
  }
]


const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})


router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.requiresAuth)) {
    // this route requires auth, check if logged in
    // if not, redirect to login page.
    console.log(userStore.state.isAuth)
    if (!userStore.state.isAuth) {
      next('/login')
    } else {
      next()
    }
  } else {
    next() // make sure to always call next()!
  }
})

export default router
