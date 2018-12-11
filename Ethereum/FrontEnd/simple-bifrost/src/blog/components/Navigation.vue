
<template>
  <div class="navigation">
    <ul>
      <li>
        <router-link to="/blog"><i class="material-icons">assignment</i></router-link>
      </li>
      <li>
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
