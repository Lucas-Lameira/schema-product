import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'
import Sale from '../views/Sale.vue'
import Purchase from '../views/Purchase.vue'
import Product from '../views/Product.vue';
import Login from '../views/Login.vue'
Vue.use(VueRouter)

const routes = [
  {
    path: '/login',
    name: 'login',
    component: Login
  },
  {
    path: '/',
    name: 'home',
    component: Home,
    meta: { requiresAuth: true } // expect an object - use meta in protected route
  },
  {
    path: '/purchases',
    name: 'purchases',
    component: Purchase,
    meta: { requiresAuth: true }
  },
  {
    path: '/sales',
    name: 'sales',
    component: Sale,
    meta: { requiresAuth: true }
  },
  {
    path: '/products',
    name: 'products',
    component: Product,
    meta: { requiresAuth: true }
  },
  {
    path: '/about',
    name: 'about',
    component: () => import(/* webpackChunkName: "about" */ '../views/About.vue')
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

// router guard
// to route: route we are going to

/* router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.requiresAuth)) {
    // need to login
    if (!this.$store.state.user) {
      this.$router.push('/')
    } else {
      next()
    }
  } else {
    next()
  }
})
 */
/* router.beforeEach((to, from, next) => {
  const requireAuth = to.matched.some(record => record.meta.requireAuth);
  if (!this.$store.state.user && requireAuth) {
    this.$router.push('/login')
  } else {
    next();
  }
})
 */
export default router
