<template>
  <div>
    <FilterMenu />

    <ProductCard />
  </div>
</template>


<script>
import FilterMenu from "../components/filterComponents/FilterMenu.vue";
import ProductCard from "../components/ProductCard.vue";

export default {
  name: "About",
  components: {
    FilterMenu,
    ProductCard,
  },
};
</script>