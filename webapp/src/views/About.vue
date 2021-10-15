<template>
  <div>
    <h1 class="text-center mt-4">
      <span class="orange--text text">App</span>Product
      <span><v-icon>mdi-user</v-icon></span>
    </h1>
    <FilterMenu />
  </div>
</template>


<script>
import FilterMenu from "../components/filterComponents/FilterMenu.vue";
export default {
  name: "About",
  components: {
    FilterMenu,
  },
  mounted() {
    console.log("mounted");
  },
  created() {
    console.log("created");
  },
};
</script>