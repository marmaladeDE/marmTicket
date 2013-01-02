<?php

class marm_ticketsystem_oxcmp_basket extends marm_ticketsystem_oxcmp_basket_parent
{
    
    public function tobasket( $sProductId = null, $dAmount = null, $aSel = null, $aPersParam = null, $blOverride = false )
    {
        // Set $blOverride always to true
        $return = parent::tobasket( $sProductId = null, $dAmount = null, $aSel = null, $aPersParam = null, true );
        
        return $return;
    }
    
}
