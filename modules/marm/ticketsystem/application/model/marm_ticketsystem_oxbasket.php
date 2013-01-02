<?php

class marm_ticketsystem_oxbasket extends marm_ticketsystem_oxbasket_parent {
    
    public function getTicketCount()
    {
        $iAllTicketSum = 0;
        
        foreach ( $this->_aBasketContents as $oBasketItem )
        {
            $iAmt               = $oBasketItem->getAmount();
            $iTickets           = $oBasketItem->getArticle( true )->oxarticles__marmticketcount->value;
            $iTicketsSum        = $iAmt*$iTickets;
            $iAllTicketSum     += $iTicketsSum;
        }
        return $iAllTicketSum;
    }
    
    
    public function getVisitorData()
    {
        $sVisitorData = oxSession::getVar('ordrem');
        
        $aVisitorData = unserialize($sVisitorData);
        
        return $aVisitorData;
    }
    
}
