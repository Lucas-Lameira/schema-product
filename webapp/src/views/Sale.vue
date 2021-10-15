<template>
  <div>
    <h1 class="my-5 text-center orange--text">Produtos para venda</h1>

    <v-btn class="pa-2 white" @click="makeSale">
      <span>cart </span>
      <span> {{ cart.length }} </span>
      <v-icon right>mdi-cart</v-icon>
    </v-btn>

    <v-container>
      <v-row>
        <v-col
          cols="12"
          lg="4"
          v-for="product in productsForSale"
          :key="product[0]"
        >
          <v-card class="mx-auto">
            <v-card-text>
              <div class="d-flex justify-space-between">
                <span class="text-h5 text--primary">{{ product[1] }}</span>

                <span v-if="product[5] == 1" class="pa-2 red white--text">
                  low
                </span>
                <span v-else class="pa-2 green white--text"> OK </span>
              </div>

              <span>Quantidade:{{ product[2] }}</span>
              <div class="text--primary">R$: {{ product[3] }}</div>
            </v-card-text>

            <v-card-actions>
              <v-btn text color="orange" @click="addToCart(product[0])">
                Add carrinho
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import api from "../services/api";
import NewProductPopup from "../components/AddProductForm.vue";

export default {
  name: "sale",
  components: {
    NewProductPopup,
  },
  data() {
    return {
      productsForSale: [],
      hidden: false,
      cart: [],
    };
  },
  async mounted() {
    try {
      const result = await api.get("/sales");
      this.productsForSale = result.data;
    } catch (error) {
      console.log(error);
    }
  },
  computed: {
    orderByCategory(id) {
      this.productsForSale.filter((product) => {
        return product[4] === id;
      });
    },
  },
  methods: {
    addToCart(id) {
      // validar se o item ja está no carrinho
      for (let i = 0; i < this.productsForSale.length; i++) {
        if (this.productsForSale[i].includes(id)) {
          this.cart.push(this.productsForSale[i]);
          break;
        }
      }

      console.log(this.cart);
    },
    async makeSale() {
      const user = this.$store.state.user;
      console.log(user);
      /* try {
        // user_id, data de venda, quantidade, cod_venda, cod_produto
        const user = this.$store.state.user

        const result = await api.post("/sales", this.cart);
        console.log(result.data);
        console.log(result.status);
        console.log(result.statusText);
      } catch (error) {
        console.log(error);
      }*/
    },
  },
};
</script>


