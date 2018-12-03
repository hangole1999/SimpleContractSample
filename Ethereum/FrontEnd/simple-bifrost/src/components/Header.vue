
<template>
  <div class="header">
    <div class="left-header">
      <Metamask/>
      <router-link class="button go-main" to="/">Main</router-link>
    </div>
    <BlogNavigation v-if="/^\/blog.*/.test($route.path)"/>
    <CollectibleNavigation v-if="/^\/collectible.*/.test($route.path)"/>
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
