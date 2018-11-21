#include <eosiolib/eosio.hpp>

using namespace eosio;

class test : public eosio::contract {
  public:
      using contract::contract;

      /// @abi action 
      void hi( int64_t data ) {
         action(
            permission_level{
               get_self(), 
               N(active)
            },
            get_self(),
            N(ontest),
            std::make_tuple(data+1)
         ).send();
      }
      
      void ontest( int64_t data ) {
      }
};

EOSIO_ABI( test, (hi) (ontest) )
