import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'
import Sale from '../views/Sale.vue'
import Purchase from '../views/Purchase.vue'
import Product from '../views/Product.vue';

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'home',
    component: Home
  },
  {
    path: '/purchases',
    name: 'purchase',
    component: Purchase
  },
  {
    path: '/sales',
    name: 'Sale',
    component: Sale
  },
  {
    path: '/products',
    name: 'product',
    component: Product
  },
  {
    path: '/about',
    name: 'about',   
    component: () => import(/* webpackChunkName: "about" */ '../views/About.vue')
  }
]


const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
