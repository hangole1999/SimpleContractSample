
<template>
  <div class="navigation">
    <ul>
      <li :class="$route.path == '/collectible' ? 'selected' : null">
        <router-link to="/collectible"><i class="material-icons">person</i></router-link>
      </li>
      <li :class="$route.path == '/collectible/postForm' ? 'selected' : null">
        <router-link to="/collectible/create"><i class="material-icons">person_add</i></router-link>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: 'Navigation'
}
</script>
