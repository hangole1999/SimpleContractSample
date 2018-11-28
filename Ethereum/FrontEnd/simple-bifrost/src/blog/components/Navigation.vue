
<template>
  <div class="navigation">
    <ul>
      <li :class="$route.path == '/blog' ? 'selected' : null">
        <router-link to="/blog"><i class="material-icons">home</i></router-link>
      </li>
      <li :class="$route.path == '/blog/postForm' ? 'selected' : null">
        <router-link to="/blog/postForm"><i class="material-icons">note_add</i></router-link>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: 'Navigation'
}
</script>
