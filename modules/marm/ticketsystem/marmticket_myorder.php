<?php

class marmPdfBlock extends PdfBlock {

    
}

class marmPdfArticleSummary extends PdfBlock
{

    /**
     * order object
     * @var object
     */
    protected $_oData = null;

    /**
     * pdf object
     * @var object
     */
    protected $_oPdf = null;

    /**
     * Constructor
     *
     * @param object $oData order object
     * @param object $oPdf  pdf object
     *
     * @return null
     */
    public function __construct( $oData, $oPdf )
    {
        $this->_oData = $oData;
        $this->_oPdf = $oPdf;
    }

    /**
     * Sets total costs values using order without discount
     *
     * @param int &$iStartPos text start position
     *
     * @return none
     */
    protected function _setTotalCostsWithoutDiscount( &$iStartPos )
    {
        $oLang = oxRegistry::getLang();

        // products netto price
        $this->line( 15, $iStartPos + 1, 195, $iStartPos + 1 );
        $sNetSum = $oLang->formatCurrency( $this->_oData->oxorder__oxtotalnetsum->value, $this->_oData->getCurrency() ).' '.$this->_oData->getCurrency()->name;
        $this->text( 50, $iStartPos + 4, $this->_oData->translate( 'ORDER_OVERVIEW_PDF_ALLPRICENETTO' ) );
        $this->text( 195 - $this->_oPdf->getStringWidth( $sNetSum ), $iStartPos + 4, $sNetSum );

        // #345 - product VAT info
        $iCtr = 0;
        foreach ( $this->_oData->getVats() as $iVat => $dVatPrice ) {
            $iStartPos += 4 * $iCtr;
            $sVATSum = $oLang->formatCurrency( $dVatPrice, $this->_oData->getCurrency() ).' '.$this->_oData->getCurrency()->name;
            $this->text( 50, $iStartPos + 8, $this->_oData->translate( 'ORDER_OVERVIEW_PDF_ZZGLVAT' ).$iVat.$this->_oData->translate( 'ORDER_OVERVIEW_PDF_PERCENTSUM' ) );
            $this->text( 195 - $this->_oPdf->getStringWidth( $sVATSum ), $iStartPos + 8, $sVATSum );
            $iCtr++;
        }

        // products brutto price
        $sBrutPrice = $oLang->formatCurrency( $this->_oData->oxorder__oxtotalbrutsum->value, $this->_oData->getCurrency() ).' '.$this->_oData->getCurrency()->name;
        $this->text( 50, $iStartPos + 12, $this->_oData->translate( 'ORDER_OVERVIEW_PDF_ALLPRICEBRUTTO' ) );
        $this->text( 195 - $this->_oPdf->getStringWidth( $sBrutPrice ), $iStartPos + 12, $sBrutPrice );
        $iStartPos++;

        // line separator
        $this->line( 50, $iStartPos + 13, 195, $iStartPos + 13 );
        $iStartPos += 5;
    }

    /**
     * Sets total costs values using order with discount
     *
     * @param int &$iStartPos text start position
     *
     * @return none
     */
    protected function _setTotalCostsWithDiscount( &$iStartPos )
    {
        $oLang = oxRegistry::getLang();

        // line separator
        $this->line( 15, $iStartPos + 1, 195, $iStartPos + 1 );

        if ( $this->_oData->isNettoMode() ) {

            // products netto price
            $sNetSum = $oLang->formatCurrency( $this->_oData->oxorder__oxtotalnetsum->value, $this->_oData->getCurrency() ).' '.$this->_oData->getCurrency()->name;
            $this->text( 50, $iStartPos + 4, $this->_oData->translate( 'ORDER_OVERVIEW_PDF_ALLPRICENETTO' ) );
            $this->text( 195 - $this->_oPdf->getStringWidth( $sNetSum ), $iStartPos + 4, $sNetSum );

            // discount
            $dDiscountVal = $this->_oData->oxorder__oxdiscount->value;
            if ( $dDiscountVal > 0 ) {
                $dDiscountVal *= -1;
            }
            $sDiscount = $oLang->formatCurrency( $dDiscountVal, $this->_oData->getCurrency() ).' '.$this->_oData->getCurrency()->name;
            $this->text( 50, $iStartPos + 8, $this->_oData->translate( 'ORDER_OVERVIEW_PDF_DISCOUNT' ) );
            $this->text( 195 - $this->_oPdf->getStringWidth( $sDiscount ), $iStartPos + 8, $sDiscount );
            $iStartPos++;

            // line separator
            $this->line( 45, $iStartPos + 8, 195, $iStartPos + 8 );

            $iCtr = 0;
            foreach ( $this->_oData->getVats() as $iVat => $dVatPrice ) {
                $iStartPos += 4 * $iCtr;
                $sVATSum = $oLang->formatCurrency( $dVatPrice, $this->_oData->getCurrency() ).' '.$this->_oData->getCurrency()->name;
                $this->text( 50, $iStartPos + 12, $this->_oData->translate( 'ORDER_OVERVIEW_PDF_ZZGLVAT' ).$iVat.$this->_oData->translate('ORDER_OVERVIEW_PDF_PERCENTSUM' ) );
                $this->text( 195 - $this->_oPdf->getStringWidth( $sVATSum ), $iStartPos + 12, $sVATSum );
                $iCtr++;
            }
            $iStartPos += 4;

            // products brutto price
            $sBrutPrice = $oLang->formatCurrency( $this->_oData->oxorder__oxtotalbrutsum->value, $this->_oData->getCurrency() ).' '.$this->_oData->getCurrency()->name;
            $this->text( 50, $iStartPos + 12, $this->_oData->translate( 'ORDER_OVERVIEW_PDF_ALLPRICEBRUTTO' ) );
            $this->text( 195 - $this->_oPdf->getStringWidth( $sBrutPrice ), $iStartPos + 12, $sBrutPrice );
            $iStartPos += 4;

        } else {
            // products brutto price
            $sBrutPrice = $oLang->formatCurrency( $this->_oData->oxorder__oxtotalbrutsum->value, $this->_oData->getCurrency() ).' '.$this->_oData->getCurrency()->name;
            $this->text( 50, $iStartPos + 4, $this->_oData->translate( 'ORDER_OVERVIEW_PDF_ALLPRICEBRUTTO' ) );
            $this->text( 195 - $this->_oPdf->getStringWidth( $sBrutPrice ), $iStartPos + 4, $sBrutPrice );

            // line separator
            $this->line( 50, $iStartPos + 5, 195, $iStartPos + 5 );

            // discount
            $dDiscountVal = $this->_oData->oxorder__oxdiscount->value;
            if ( $dDiscountVal > 0 ) {
                $dDiscountVal *= -1;
            }
            $sDiscount = $oLang->formatCurrency( $dDiscountVal, $this->_oData->getCurrency() ).' '.$this->_oData->getCurrency()->name;
            $this->text( 05, $iStartPos + 8, $this->_oData->translate( 'ORDER_OVERVIEW_PDF_DISCOUNT' ) );
            $this->text( 195 - $this->_oPdf->getStringWidth( $sDiscount ), $iStartPos + 8, $sDiscount );
            $iStartPos++;

            // line separator
            $this->line( 50, $iStartPos + 8, 195, $iStartPos + 8 );
            $iStartPos += 4;

            // products netto price
            $sNetSum = $oLang->formatCurrency( $this->_oData->oxorder__oxtotalnetsum->value, $this->_oData->getCurrency() ).' '.$this->_oData->getCurrency()->name;
            $this->text( 50, $iStartPos + 8, $this->_oData->translate( 'ORDER_OVERVIEW_PDF_ALLPRICENETTO' ) );
            $this->text( 195 - $this->_oPdf->getStringWidth( $sNetSum ), $iStartPos + 8, $sNetSum );

            // #345 - product VAT info
            $iCtr = 0;
            foreach ( $this->_oData->getVats() as $iVat => $dVatPrice ) {
                $iStartPos += 4 * $iCtr;
                $sVATSum = $oLang->formatCurrency( $dVatPrice, $this->_oData->getCurrency() ).' '.$this->_oData->getCurrency()->name;
                $this->text( 50, $iStartPos + 12, $this->_oData->translate( 'ORDER_OVERVIEW_PDF_ZZGLVAT' ).$iVat.$this->_oData->translate('ORDER_OVERVIEW_PDF_PERCENTSUM' ) );
                $this->text( 195 - $this->_oPdf->getStringWidth( $sVATSum ), $iStartPos + 12, $sVATSum );
                $iCtr++;
            }
            $iStartPos += 4;
        }
    }

    /**
     * Sets voucher values to pdf
     *
     * @param int &$iStartPos text start position
     *
     * @return none
     */
    protected function _setVoucherInfo( &$iStartPos )
    {
        $dVoucher = 0;
        if ( $this->_oData->oxorder__oxvoucherdiscount->value ) {
            $dDiscountVal = $this->_oData->oxorder__oxvoucherdiscount->value;
            if ( $dDiscountVal > 0 ) {
                $dDiscountVal *= -1;
            }
            $sPayCost = oxRegistry::getLang()->formatCurrency( $dDiscountVal, $this->_oData->getCurrency() ).' '.$this->_oData->getCurrency()->name;
            $this->text( 50, $iStartPos, $this->_oData->translate( 'ORDER_OVERVIEW_PDF_VOUCHER' ) );
            $this->text( 195 - $this->_oPdf->getStringWidth( $sPayCost ), $iStartPos, $sPayCost );
            $iStartPos += 4;
        }

        $iStartPos++;
    }

    /**
     * Sets delivery info to pdf
     *
     * @param int &$iStartPos text start position
     *
     * @return none
     */
    protected function _setDeliveryInfo( &$iStartPos )
    {
        $sAddString = '';
        $oLang = oxRegistry::getLang();
        $oConfig = oxRegistry::getConfig();

        if ( $oConfig->getConfigParam( 'blShowVATForDelivery' ) ) {
            // delivery netto
            $sDelCostNetto = $oLang->formatCurrency( $this->_oData->getOrderDeliveryPrice()->getNettoPrice(), $this->_oData->getCurrency() ).' '.$this->_oData->getCurrency()->name;
            $this->text( 50, $iStartPos, $this->_oData->translate( 'ORDER_OVERVIEW_PDF_SHIPCOST' ).' '.$this->_oData->translate('ORDER_OVERVIEW_PDF_NETTO' ) );
            $this->text( 195 - $this->_oPdf->getStringWidth( $sDelCostNetto ), $iStartPos, $sDelCostNetto );
            $iStartPos += 4;

            if ( $oConfig->getConfigParam('sAdditionalServVATCalcMethod') != 'proportional' ) {
                $sVatValueText = $this->_oData->translate( 'ORDER_OVERVIEW_PDF_ZZGLVAT' ).$this->_oData->oxorder__oxdelvat->value.$this->_oData->translate( 'ORDER_OVERVIEW_PDF_PERCENTSUM' );
            } else {
                $sVatValueText = $this->_oData->translate( 'TOTAL_PLUS_PROPORTIONAL_VAT' );
            }

            // delivery VAT
            $sDelCostVAT = $oLang->formatCurrency( $this->_oData->getOrderDeliveryPrice()->getVATValue(), $this->_oData->getCurrency()).' '.$this->_oData->getCurrency()->name;
            $this->text( 50, $iStartPos, $sVatValueText );
            $this->text( 195 - $this->_oPdf->getStringWidth( $sDelCostVAT ), $iStartPos, $sDelCostVAT );
            //$iStartPos += 4;

            $sAddString = ' '.$this->_oData->translate( 'ORDER_OVERVIEW_PDF_BRUTTO' );
        } else {
            // if canceled order, reset value
            if ( $this->_oData->oxorder__oxstorno->value ) {
                $this->_oData->oxorder__oxdelcost->setValue(0);
            }

            $sDelCost = $oLang->formatCurrency( $this->_oData->oxorder__oxdelcost->value, $this->_oData->getCurrency() ).' '.$this->_oData->getCurrency()->name;
            $this->text( 50, $iStartPos, $this->_oData->translate( 'ORDER_OVERVIEW_PDF_SHIPCOST' ).$sAddString );
            $this->text( 195 - $this->_oPdf->getStringWidth( $sDelCost ), $iStartPos, $sDelCost );
        }
    }

    /**
     * Sets wrapping info to pdf
     *
     * @param int &$iStartPos text start position
     *
     * @return none
     */
    protected function _setWrappingInfo( &$iStartPos )
    {
        if ( $this->_oData->oxorder__oxwrapcost->value ) {
            $sAddString = '';
            $oLang = oxRegistry::getLang();
            $oConfig = oxRegistry::getConfig();

            //displaying wrapping VAT info
            if ( $oConfig->getConfigParam('blShowVATForWrapping') ) {

                if ($this->_oData->oxorder__oxwrapcost->value) {
                    // wrapping netto
                    $iStartPos += 4;
                    $sWrapCostNetto = $oLang->formatCurrency( $this->_oData->getOrderWrappingPrice()->getNettoPrice(), $this->_oData->getCurrency()).' '.$this->_oData->getCurrency()->name;
                    $this->text( 45, $iStartPos, $this->_oData->translate( 'WRAPPING_COSTS' ).' '.$this->_oData->translate( 'ORDER_OVERVIEW_PDF_NETTO' ) );
                    $this->text( 195 - $this->_oPdf->getStringWidth( $sWrapCostNetto ), $iStartPos, $sWrapCostNetto );
                    //$iStartPos++;

                    //wrapping VAT
                    $iStartPos += 4;
                    $sWrapCostVAT = $oLang->formatCurrency( $this->_oData->getOrderWrappingPrice()->getVATValue(), $this->_oData->getCurrency()).' '.$this->_oData->getCurrency()->name;
                    $this->text( 45, $iStartPos, $this->_oData->translate( 'ORDER_OVERVIEW_PDF_ZZGLVAT' ) );
                    $this->text( 195 - $this->_oPdf->getStringWidth( $sWrapCostVAT ), $iStartPos, $sWrapCostVAT );
                   // $iStartPos++;
                }


                if ($this->_oData->oxorder__oxgiftcardcost->value) {
                    // wrapping netto
                    $iStartPos += 4;
                    $sWrapCostNetto = $oLang->formatCurrency( $this->_oData->getOrderGiftCardPrice()->getNettoPrice(), $this->_oData->getCurrency()).' '.$this->_oData->getCurrency()->name;
                    $this->text( 45, $iStartPos, $this->_oData->translate( 'GIFTCARD_COSTS' ).' '.$this->_oData->translate( 'ORDER_OVERVIEW_PDF_NETTO' ) );
                    $this->text( 195 - $this->_oPdf->getStringWidth( $sWrapCostNetto ), $iStartPos, $sWrapCostNetto );
                    //$iStartPos++;

                    //wrapping VAT
                    $iStartPos += 4;
                    $sWrapCostVAT = $oLang->formatCurrency( $this->_oData->getOrderGiftCardPrice()->getVATValue(), $this->_oData->getCurrency()).' '.$this->_oData->getCurrency()->name;

                    if ( $oConfig->getConfigParam('sAdditionalServVATCalcMethod') != 'proportional' ) {
                        $sVatValueText = $this->_oData->translate( 'ORDER_OVERVIEW_PDF_ZZGLVAT' ) .$this->_oData->oxorder__oxgiftcardvat->value.$this->_oData->translate( 'ORDER_OVERVIEW_PDF_PERCENTSUM' );
                    } else {
                        $sVatValueText = $this->_oData->translate( 'TOTAL_PLUS_PROPORTIONAL_VAT' );
                    }

                    $this->text( 45, $iStartPos, $sVatValueText );
                    $this->text( 195 - $this->_oPdf->getStringWidth( $sWrapCostVAT ), $iStartPos, $sWrapCostVAT );
                    $iStartPos++;
                }

            } else {
                $iStartPos += 4;

                if ($this->_oData->oxorder__oxwrapcost->value) {
                    // wrapping cost
                    $sAddString = ' '.$this->_oData->translate( 'ORDER_OVERVIEW_PDF_BRUTTO' );
                    $sWrapCost = $oLang->formatCurrency( $this->_oData->oxorder__oxwrapcost->value, $this->_oData->getCurrency() ).' '.$this->_oData->getCurrency()->name;
                    $this->text( 45, $iStartPos, $this->_oData->translate( 'WRAPPING_COSTS'/*'ORDER_OVERVIEW_PDF_WRAPPING'*/ ).$sAddString );
                    $this->text( 195 - $this->_oPdf->getStringWidth( $sWrapCost ), $iStartPos, $sWrapCost );
                    $iStartPos++;
                }

                if ($this->_oData->oxorder__oxgiftcardcost->value) {
                    $iStartPos += 4;
                // gift card cost
                    $sWrapCost = $oLang->formatCurrency( $this->_oData->oxorder__oxgiftcardcost->value, $this->_oData->getCurrency() ).' '.$this->_oData->getCurrency()->name;
                    $this->text( 45, $iStartPos, $this->_oData->translate( 'GIFTCARD_COSTS' ).$sAddString );
                    $this->text( 195 - $this->_oPdf->getStringWidth( $sWrapCost ), $iStartPos, $sWrapCost );
                    $iStartPos++;
                }

            }

        }
    }

    /**
     * Sets payment info to pdf
     *
     * @param int &$iStartPos text start position
     *
     * @return none
     */
    protected function _setPaymentInfo( &$iStartPos )
    {
        $oLang = oxRegistry::getLang();
        $oConfig = oxRegistry::getConfig();

        if ( $this->_oData->oxorder__oxstorno->value ) {
                $this->_oData->oxorder__oxpaycost->setValue(0);
        }

        if ($oConfig->getConfigParam('blShowVATForDelivery')) {
            if ( $this->_oData->oxorder__oxpayvat->value ) {
                // payment netto
                $iStartPos += 4;
                $sPayCostNetto = $oLang->formatCurrency( $this->_oData->getOrderPaymentPrice()->getNettoPrice(), $this->_oData->getCurrency() ).' '.$this->_oData->getCurrency()->name;
                $this->text( 50, $iStartPos, $this->_oData->translate( 'ORDER_OVERVIEW_PDF_PAYMENTIMPACT' ).' '.$this->_oData->translate( 'ORDER_OVERVIEW_PDF_NETTO' ) );
                $this->text( 195 - $this->_oPdf->getStringWidth( $sPayCostNetto ), $iStartPos, $sPayCostNetto );

                if ( $oConfig->getConfigParam('sAdditionalServVATCalcMethod') != 'proportional' ) {
                    $sVatValueText = $this->_oData->translate( 'ORDER_OVERVIEW_PDF_ZZGLVAT' ).$this->_oData->oxorder__oxpayvat->value.$this->_oData->translate( 'ORDER_OVERVIEW_PDF_PERCENTSUM' );
                } else {
                    $sVatValueText = $this->_oData->translate( 'TOTAL_PLUS_PROPORTIONAL_VAT' );
                }

                // payment VAT
                $iStartPos += 4;
                $sPayCostVAT = $oLang->formatCurrency( $this->_oData->getOrderPaymentPrice()->getVATValue(), $this->_oData->getCurrency() ).' '.$this->_oData->getCurrency()->name;
                $this->text( 50, $iStartPos, $sVatValueText );
                $this->text( 195 - $this->_oPdf->getStringWidth( $sPayCostVAT ), $iStartPos, $sPayCostVAT );

            }

            // if canceled order, reset value

        } else {

            // payment costs
            if ( $this->_oData->oxorder__oxpaycost->value ) {
                $iStartPos += 4;
                $sPayCost = $oLang->formatCurrency( $this->_oData->oxorder__oxpaycost->value, $this->_oData->getCurrency() ).' '.$this->_oData->getCurrency()->name;
                $this->text( 50, $iStartPos, $this->_oData->translate( 'ORDER_OVERVIEW_PDF_PAYMENTIMPACT' ) );
                $this->text( 195 - $this->_oPdf->getStringWidth( $sPayCost ), $iStartPos, $sPayCost );
            }

            $iStartPos++;
        }
    }

    /**
     * Sets payment info to pdf
     *
     * @param int &$iStartPos text start position
     *
     * @return none
     */
    protected function _setTsProtection( &$iStartPos )
    {
        $oLang   = oxRegistry::getLang();
        $oConfig = oxRegistry::getConfig();
        if ( $this->_oData->oxorder__oxtsprotectcosts->value && $oConfig->getConfigParam( 'blShowVATForPayCharge' ) ) {

            // payment netto
            $iStartPos += 4;
            $sPayCostNetto = $oLang->formatCurrency( $this->_oData->getOrderTsProtectionPrice()->getNettoPrice(), $this->_oData->getCurrency() ).' '.$this->_oData->getCurrency()->name;
            $this->text( 45, $iStartPos, $this->_oData->translate( 'ORDER_OVERVIEW_PDF_TSPROTECTION' ).' '.$this->_oData->translate( 'ORDER_OVERVIEW_PDF_NETTO' ) );
            $this->text( 195 - $this->_oPdf->getStringWidth( $sPayCostNetto ), $iStartPos, $sPayCostNetto );

            // payment VAT
            $iStartPos += 4;
            $sPayCostVAT = $oLang->formatCurrency( $this->_oData->getOrderTsProtectionPrice()->getVATValue(), $this->_oData->getCurrency() ).' '.$this->_oData->getCurrency()->name;
            $this->text( 45, $iStartPos, $this->_oData->translate( 'ORDER_OVERVIEW_PDF_ZZGLVAT' ).$oConfig->getConfigParam( 'dDefaultVAT' ).$this->_oData->translate( 'ORDER_OVERVIEW_PDF_PERCENTSUM' ) );
            $this->text( 195 - $this->_oPdf->getStringWidth( $sPayCostVAT ), $iStartPos, $sPayCostVAT );

            $iStartPos++;

        } elseif ( $this->_oData->oxorder__oxtsprotectcosts->value ) {

            $iStartPos += 4;
            $sPayCost = $oLang->formatCurrency( $this->_oData->oxorder__oxtsprotectcosts->value, $this->_oData->getCurrency() ).' '.$this->_oData->getCurrency()->name;
            $this->text( 45, $iStartPos, $this->_oData->translate( 'ORDER_OVERVIEW_PDF_TSPROTECTION' ) );
            $this->text( 195 - $this->_oPdf->getStringWidth( $sPayCost ), $iStartPos, $sPayCost );

            $iStartPos++;
        }
    }

    /**
     * Sets grand total order price to pdf
     *
     * @param int &$iStartPos text start position
     *
     * @return none
     */
    protected function _setGrandTotalPriceInfo( &$iStartPos )
    {
        $this->font( $this->getFont(), 'B', 10 );

        // total order sum
        $sTotalOrderSum = $this->_oData->getFormattedTotalOrderSum() . ' ' . $this->_oData->getCurrency()->name;
        $this->text( 50, $iStartPos, $this->_oData->translate( 'ORDER_OVERVIEW_PDF_ALLSUM' ) );
        $this->text( 195 - $this->_oPdf->getStringWidth( $sTotalOrderSum ), $iStartPos, $sTotalOrderSum );
        $iStartPos += 2;

        if ( $this->_oData->oxorder__oxdelvat->value || $this->_oData->oxorder__oxwrapvat->value || $this->_oData->oxorder__oxpayvat->value ) {
            $iStartPos += 2;
        }
    }

    /**
     * Sets payment method info to pdf
     *
     * @param int &$iStartPos text start position
     *
     * @return none
     */
    protected function _setPaymentMethodInfo( &$iStartPos )
    {
        $oPayment = oxNew( 'oxpayment' );
        $oPayment->loadInLang( $this->_oData->getSelectedLang(), $this->_oData->oxorder__oxpaymenttype->value );

        $text = $this->_oData->translate( 'ORDER_OVERVIEW_PDF_SELPAYMENT' ).str_replace('&amp;','&',$oPayment->oxpayments__oxdesc->value);
        $this->font( $this->getFont(), '', 10 );
        $this->text( 15, $iStartPos + 4, $text );
        $iStartPos += 4;
    }

    /**
     * Sets pay until date to pdf
     *
     * @param int &$iStartPos text start position
     *
     * @return none
     */
    protected function _setPayUntilInfo( &$iStartPos )
    {
        $aPayData = explode('-',$this->_oData->oxorder__oxbilldate->value);
        $text = $this->_oData->translate( 'ORDER_OVERVIEW_PDF_PAYUPTO' ) . $aPayData[2].'.'.$aPayData[1].'.'.$aPayData[0]; //date( 'd.m.Y', mktime( 0, 0, 0, date ( 'm' ), date ( 'd' ) + 7, date( 'Y' ) ) );
        $this->font( $this->getFont(), '', 10 );
        $this->text( 15, $iStartPos + 4, $text );
        $iStartPos += 4;
    }

    /**
     * Generates order info block (prices, VATs, etc )
     *
     * @param int $iStartPos text start position
     *
     * @return int
     */
    public function generate( $iStartPos )
    {

        $this->font( $this->getFont(), '', 10 );
        $siteH = $iStartPos;

        // #1147 discount for vat must be displayed
        if ( !$this->_oData->oxorder__oxdiscount->value ) {
            $this->_setTotalCostsWithoutDiscount( $siteH );
        } else {
            $this->_setTotalCostsWithDiscount( $siteH );
        }

        $siteH += 12;

        // voucher info
        $this->_setVoucherInfo( $siteH );

        // additional line separator
        if ( $this->_oData->oxorder__oxdiscount->value || $this->_oData->oxorder__oxvoucherdiscount->value ) {
            $this->line( 45, $siteH - 3, 195, $siteH - 3 );
        }

        // delivery info
        $this->_setDeliveryInfo( $siteH );

        // payment info
        $this->_setPaymentInfo( $siteH );

        // wrapping info
        $this->_setWrappingInfo( $siteH );

        // TS protection info
        $this->_setTsProtection( $siteH );

        // separating line
        $this->line( 15, $siteH, 195, $siteH );
        $siteH += 4;

        // total order sum
        $this->_setGrandTotalPriceInfo( $siteH );

        // separating line
        $this->line( 15, $siteH, 195, $siteH );
        $siteH += 4;

        // payment method
        $this->_setPaymentMethodInfo( $siteH );

        // pay until ...
        $this->_setPayUntilInfo( $siteH );

        return $siteH - $iStartPos;
    }
}



class marmticket_myorder extends marmticket_myorder_parent{
    
    
    public function exportStandart( $oPdf )
    {
        // preparing order curency info
        $myConfig = $this->getConfig();
        $oPdfBlock = new PdfBlock();

        $this->_oCur = $myConfig->getCurrencyObject( $this->oxorder__oxcurrency->value );
        if ( !$this->_oCur ) {
            $this->_oCur = $myConfig->getActShopCurrencyObject();
        }

        // loading active shop
        $oShop = $this->_getActShop();

        // shop information
        $oPdf->setFont( $oPdfBlock->getFont(), '', 6 );
        $oPdf->text( 15, 55, $oShop->oxshops__oxname->getRawValue().' - '.$oShop->oxshops__oxstreet->getRawValue().' - '.$oShop->oxshops__oxzip->value.' - '.$oShop->oxshops__oxcity->getRawValue() );

        // billing address
        $this->_setBillingAddressToPdf( $oPdf );

        // delivery address
        if ( $this->oxorder__oxdelsal->value ) {
            $this->_setDeliveryAddressToPdf( $oPdf );
        }

        // loading user
        $oUser = oxNew( 'oxuser' );
        $oUser->load( $this->oxorder__oxuserid->value );

        // user info
        $sText = $this->translate( 'ORDER_OVERVIEW_PDF_FILLONPAYMENT' );
        $oPdf->setFont( $oPdfBlock->getFont(), '', 5 );
        $oPdf->text( 195 - $oPdf->getStringWidth( $sText ), 65, $sText );

        // customer number
        $sCustNr = $this->translate( 'ORDER_OVERVIEW_PDF_CUSTNR').' '.$oUser->oxuser__oxcustnr->value;
        $oPdf->setFont( $oPdfBlock->getFont(), '', 7 );
        $oPdf->text( 195 - $oPdf->getStringWidth( $sCustNr ), 69, $sCustNr );

        // setting position if delivery address is used
        if ( $this->oxorder__oxdelsal->value ) {
            $iTop = 115;
        } else {
            $iTop = 91;
        }

        // shop city
        $sText = $oShop->oxshops__oxcity->getRawValue().', '.date( 'd.m.Y' );
        $oPdf->setFont( $oPdfBlock->getFont(), '', 10 );
        $oPdf->text( 195 - $oPdf->getStringWidth( $sText ), $iTop + 8, $sText );

        // shop VAT number
        if ( $oShop->oxshops__oxvatnumber->value ) {
            $sText = $this->translate( 'ORDER_OVERVIEW_PDF_TAXIDNR' ).' '.$oShop->oxshops__oxvatnumber->value;
            $oPdf->text( 195 - $oPdf->getStringWidth( $sText ), $iTop + 12, $sText );
            $iTop += 8;
        } else {
            $iTop += 4;
        }

        // invoice number
        $sText = $this->translate( 'ORDER_OVERVIEW_PDF_COUNTNR' ).' '.$this->oxorder__oxbillnr->value;
        $oPdf->text( 195 - $oPdf->getStringWidth( $sText ), $iTop + 8, $sText );

        // marking if order is canceled
        if ( $this->oxorder__oxstorno->value == 1 ) {
            $this->oxorder__oxordernr->setValue( $this->oxorder__oxordernr->getRawValue() . '   '.$this->translate( 'ORDER_OVERVIEW_PDF_STORNO' ), oxField::T_RAW );
        }

        // order number
        $oPdf->setFont( $oPdfBlock->getFont(), '', 12 );
        $oPdf->text( 15, $iTop, $this->translate( 'ORDER_OVERVIEW_PDF_PURCHASENR' ).' '.$this->oxorder__oxordernr->value );

        // order date
        $oPdf->setFont( $oPdfBlock->getFont(), '', 10 );
        $aOrderDate = explode( ' ', $this->oxorder__oxorderdate->value );
        $sOrderDate = oxRegistry::get("oxUtilsDate")->formatDBDate( $aOrderDate[0]);
        $oPdf->text( 15, $iTop + 8, $this->translate( 'ORDER_OVERVIEW_PDF_ORDERSFROM' ).$sOrderDate.$this->translate( 'ORDER_OVERVIEW_PDF_ORDERSAT' ).$oShop->oxshops__oxurl->value );
        $iTop += 16;

        // product info header
        $oPdf->setFont( $oPdfBlock->getFont(), '', 8 );
        $oPdf->text( 15, $iTop, $this->translate( 'ORDER_OVERVIEW_PDF_AMOUNT' ) );
        $oPdf->text( 30, $iTop, $this->translate( 'ORDER_OVERVIEW_PDF_ARTID' ) );
        $oPdf->text( 50, $iTop, $this->translate( 'ORDER_OVERVIEW_PDF_DESC' ) );
        $oPdf->text( 135, $iTop, $this->translate( 'ORDER_OVERVIEW_PDF_VAT' ) );
        $oPdf->text( 148, $iTop, $this->translate( 'ORDER_OVERVIEW_PDF_UNITPRICE' ) );
        $sText = $this->translate( 'ORDER_OVERVIEW_PDF_ALLPRICE' );
        $oPdf->text( 195 - $oPdf->getStringWidth( $sText ), $iTop, $sText );

        // separator line
        $iTop += 2;
        $oPdf->line( 15, $iTop, 195, $iTop );

        // #345
        $siteH = $iTop;
        $oPdf->setFont( $oPdfBlock->getFont(), '', 10 );

        // order articles
        $this->_setOrderArticlesToPdf( $oPdf, $siteH, true );

        // generating pdf file
        $oArtSumm = new marmPdfArticleSummary( $this, $oPdf );
        
        $iHeight = $oArtSumm->generate( $siteH );
        if ( $siteH + $iHeight > 258 ) {
            $this->pdfFooter( $oPdf );
            $iTop = $this->pdfHeader( $oPdf );
            $oArtSumm->ajustHeight( $iTop - $siteH );
            $siteH = $iTop;
        }

        $oArtSumm->run( $oPdf );
        $siteH += $iHeight + 8;
        
        // set Visitordata to PDF
        $aVisitorData = unserialize( $this->oxorder__oxremark->rawValue );
        
        $oPdf->text( 15, $siteH, 'Ticket(s) gültig für folgende Teilnehmer:' );
        $siteH += 10;
        $vNr = 1;
        foreach( $aVisitorData as $visitor )
        {
            $oPdf->text( 15, $siteH, 'Teilnehmer '. $vNr .':' );
            $oPdf->text( 45, $siteH, $visitor['fname'].' '.$visitor['lname'].' ('.$visitor['position'].')');
            $oPdf->text( 45, $siteH + 5, 'T-Shirt: '.$visitor['tshirt']);
            $siteH += 10;
            $vNr++;
        }
        
        $siteH += 10;
        $oPdf->text( 15, $siteH, $this->translate( 'ORDER_OVERVIEW_PDF_GREETINGS' ) );
    }
    
    
    protected function _setOrderArticlesToPdf( $oPdf, &$iStartPos, $blShowPrice = true )
    {
        if (!$this->_oArticles) {
            $this->_oArticles = $this->getOrderArticles(true);
        }

        $oCurr = $this->getCurrency();
        $oPdfBlock = new PdfBlock();
        // product list
        foreach ( $this->_oArticles as $key => $oOrderArt ) {

            // starting a new page ...
            if ( $iStartPos > 243 ) {
                $this->pdffooter( $oPdf );
                $iStartPos = $this->pdfheaderplus( $oPdf );
                $oPdf->setFont( $oPdfBlock->getFont(), '', 10 );
            } else {
                $iStartPos = $iStartPos + 4;
            }

            // sold amount
            $oPdf->text( 20 - $oPdf->getStringWidth( $oOrderArt->oxorderarticles__oxamount->value ), $iStartPos, $oOrderArt->oxorderarticles__oxamount->value );

            // product number
            $oPdf->setFont( $oPdfBlock->getFont(), '', 8 );
            $oPdf->text( 28, $iStartPos, $oOrderArt->oxorderarticles__oxartnum->value );

            // product title
            $oPdf->setFont( $oPdfBlock->getFont(), '', 10 );
            $oPdf->text( 50, $iStartPos, substr( strip_tags( $this->_replaceExtendedChars( $oOrderArt->oxorderarticles__oxtitle->getRawValue(), true ) ), 0, 58 ) );

            if ( $blShowPrice ) {
                $oLang = oxRegistry::getLang();

                // product VAT percent
                $oPdf->text( 140 - $oPdf->getStringWidth( $oOrderArt->oxorderarticles__oxvat->value ), $iStartPos, $oOrderArt->oxorderarticles__oxvat->value );

                // product price

                $dUnitPrice = ($this->isNettoMode()) ? $oOrderArt->oxorderarticles__oxnprice->value : $oOrderArt->oxorderarticles__oxbprice->value;
                $dTotalPrice = ($this->isNettoMode()) ? $oOrderArt->oxorderarticles__oxnetprice->value : $oOrderArt->oxorderarticles__oxbrutprice->value;

                $sText = $oLang->formatCurrency( $dUnitPrice, $this->_oCur ).' '.$this->_oCur->name;
                $oPdf->text( 163 - $oPdf->getStringWidth( $sText ), $iStartPos, $sText );

                // total product price
                $sText = $oLang->formatCurrency( $dTotalPrice, $this->_oCur ).' '.$this->_oCur->name;
                $oPdf->text( 195 - $oPdf->getStringWidth( $sText ), $iStartPos, $sText );

            }

            // additional variant info
            if ( $oOrderArt->oxorderarticles__oxselvariant->value ) {
                $iStartPos = $iStartPos + 4;
                $oPdf->text( 45, $iStartPos, substr( $oOrderArt->oxorderarticles__oxselvariant->value, 0, 58 ) );
            }

        }
    }

}