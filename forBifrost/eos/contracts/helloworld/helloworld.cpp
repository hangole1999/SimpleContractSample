#include <eosiolib/eosio.hpp>

using namespace eosio;

class helloworld : public eosio::contract {
  public:
      using contract::contract;

      /// @abi action 
      void greet( account_name user ) {
         print( "Hello World, ", name{user} );
      }
};

EOSIO_ABI( helloworld, (greet) )
