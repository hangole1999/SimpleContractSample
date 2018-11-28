import Vue from 'vue'
import Router from 'vue-router'
import Home from './views/Home.vue'
import BlogHome from './blog/views/Home.vue'
import PostForm from './blog/views/PostForm.vue'
import CollectibleHome from './collectible/views/Home.vue'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home
    },
    {
      path: '/blog',
      name: 'blogHome',
      component: BlogHome
    },
    {
      path: '/blog/postForm',
      name: 'postForm',
      component: PostForm
    },
    {
      path: '/collectible',
      name: 'collectibleHome',
      component: CollectibleHome
    }
  ]
})
