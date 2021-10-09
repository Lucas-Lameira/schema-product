<template>
   <nav>
      <v-toolbar>      

      <v-toolbar-title>
         <span class="orange--text font-weight-bold">APP</span>
         <span class="font-weight-medium">roduct</span>         
      </v-toolbar-title>

      <v-spacer></v-spacer>
      
      <div>
         <v-tabs>           
            <v-tab v-for="route in routes" :key="route.name" :to="route.route" exact>
               {{route.name}}
            </v-tab>
         </v-tabs>
      </div>

      <v-spacer></v-spacer>

      <v-btn>
        <span>Sign out</span>
        <v-icon right>mdi-export</v-icon>
      </v-btn>
    </v-toolbar>
   </nav>
</template>

<script>
export default{ 
   data(){
      return{
         routes: [
            {route: '/', name: 'Home'},
            {route: '/products', name: 'Products'},
            {route: '/sales', name: 'Sales'},
            {route: '/purchases', name: 'Purchase'},
            {route: '/about', name: 'About'}
         ]
      }
   }
}
</script>