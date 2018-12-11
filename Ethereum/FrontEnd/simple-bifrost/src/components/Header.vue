
<template>
  <div class="header">
    <div class="left-header">
      <router-link class="button go-main" to="/"><i class="material-icons">home</i></router-link>
      <BlogNavigation v-if="/^\/blog.*/.test($route.path)"/>
      <CollectibleNavigation v-if="/^\/collectible.*/.test($route.path)"/>
    </div>
    <div class="left-bottom-header">
      <Metamask/>
    </div>
  </div>
</template>

<script>
import Metamask from './Metamask.vue';
import BlogNavigation from '../blog/components/Navigation.vue';
import CollectibleNavigation from '../collectible/components/Navigation.vue';

export default {
  name: 'Header',
  components: {
    Metamask,
    BlogNavigation,
    CollectibleNavigation
  }
}
</script>
