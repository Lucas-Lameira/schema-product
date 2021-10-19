<template>
  <div>
    <ProductCard />
  </div>
</template>


<script>
import FilterMenu from "../components/filterComponents/FilterMenu.vue";
import ProductCard from "../components/ProductCard.vue";

export default {
  name: "Sale",
  components: {
    FilterMenu,
    ProductCard,
  },
};
</script>