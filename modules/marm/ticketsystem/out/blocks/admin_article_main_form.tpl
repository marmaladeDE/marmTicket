 [{ if $errorsavingatricle }]
  <tr>
    <td colspan="2">
      [{ if $errorsavingatricle eq 1 }]
      <div class="errorbox">[{ oxmultilang ident="ARTICLE_MAIN_ERRORSAVINGARTICLE" }]</div>
      [{/if}]
    </td>
  </tr>
  [{ /if}]

  [{ if $oxparentid }]
  <tr>
    <td class="edittext" width="120">
        <b>[{ oxmultilang ident="ARTICLE_MAIN_VARIANTE" }]</b>
    </td>
    <td class="edittext">
      <a href="Javascript:editThis('[{ $parentarticle->oxarticles__oxid->value}]');" class="edittext"><b>[{ $parentarticle->oxarticles__oxartnum->value }] [{ $parentarticle->oxarticles__oxtitle->value}] [{if !$parentarticle->oxarticles__oxtitle->value }][{ $parentarticle->oxarticles__oxvarselect->value }][{/if}]</b></a>
    </td>
  </tr>
  [{ /if}]

    <tr>
      <td class="edittext" width="120">
        [{ oxmultilang ident="ARTICLE_MAIN_ACTIVE" }]
      </td>
      <td class="edittext">
        <input type="hidden" name="editval[oxarticles__oxactive]" value="0">
        <input class="edittext" type="checkbox" name="editval[oxarticles__oxactive]" value='1' [{if $edit->oxarticles__oxactive->value == 1}]checked[{/if}] [{ $readonly }]>
        [{ oxinputhelp ident="HELP_ARTICLE_MAIN_ACTIVE" }]
      </td>
    </tr>

    [{ if $blUseTimeCheck }]
    <tr>
      <td class="edittext">
        [{ oxmultilang ident="ARTICLE_MAIN_ACTIVFROMTILL" }]&nbsp;
      </td>
      <td class="edittext">
        [{ oxmultilang ident="ARTICLE_MAIN_ACTIVEFROM" }]&nbsp;<input type="text" class="editinput" size="27" name="editval[oxarticles__oxactivefrom]" value="[{$edit->oxarticles__oxactivefrom|oxformdate}]" [{include file="help.tpl" helpid=article_vonbis}] [{ $readonly }]><br>
        [{ oxmultilang ident="ARTICLE_MAIN_ACTIVETO" }]&nbsp;&nbsp;<input type="text" class="editinput" size="27" name="editval[oxarticles__oxactiveto]" value="[{$edit->oxarticles__oxactiveto|oxformdate}]" [{include file="help.tpl" helpid=article_vonbis}] [{ $readonly }]>
        [{ oxinputhelp ident="HELP_ARTICLE_MAIN_ACTIVFROMTILL" }]
      </td>
    </tr>
    [{ /if }]

    <tr>
      <td class="edittext">
        [{ oxmultilang ident="ARTICLE_MAIN_TITLE" }]&nbsp;
      </td>
      <td class="edittext">
        <input type="text" class="editinput" size="32" maxlength="[{$edit->oxarticles__oxtitle->fldmax_length}]" id="oLockTarget" name="editval[oxarticles__oxtitle]" value="[{$edit->oxarticles__oxtitle->value}]">
        [{ oxinputhelp ident="HELP_ARTICLE_MAIN_TITLE" }]
      </td>
    </tr>
    <tr>
      <td class="edittext">
        [{ oxmultilang ident="ARTICLE_MAIN_ARTNUM" }]&nbsp;
      </td>
      <td class="edittext">
        <input type="text" class="editinput" size="32" maxlength="[{$edit->oxarticles__oxartnum->fldmax_length}]" name="editval[oxarticles__oxartnum]" value="[{$edit->oxarticles__oxartnum->value}]" [{ $readonly }]>
        [{ oxinputhelp ident="HELP_ARTICLE_MAIN_ARTNUM" }]
      </td>
    </tr>

    <tr>
      <td class="edittext">
        [{ oxmultilang ident="ARTICLE_MAIN_EAN" }]&nbsp;
      </td>
      <td class="edittext">
        <input type="text" class="editinput" size="32" maxlength="[{$edit->oxarticles__oxean->fldmax_length}]" name="editval[oxarticles__oxean]" value="[{$edit->oxarticles__oxean->value}]">
        [{ oxinputhelp ident="HELP_ARTICLE_MAIN_EAN" }]
      </td>
    </tr>

    <tr>
      <td class="edittext">
        [{ oxmultilang ident="ARTICLE_MAIN_DISTEAN" }]&nbsp;
      </td>
      <td class="edittext">
        <input type="text" class="editinput" size="32" maxlength="[{$edit->oxarticles__oxdistean->fldmax_length}]" name="editval[oxarticles__oxdistean]" value="[{$edit->oxarticles__oxdistean->value}]">
        [{ oxinputhelp ident="HELP_ARTICLE_MAIN_DISTEAN" }]
      </td>
    </tr>

    <tr>
      <td class="edittext">
        [{ oxmultilang ident="ARTICLE_MAIN_MPN" }]&nbsp;
      </td>
      <td class="edittext">
        <input type="text" class="editinput" size="32" maxlength="[{$edit->oxarticles__oxmpn->fldmax_length}]" name="editval[oxarticles__oxmpn]" value="[{$edit->oxarticles__oxmpn->value}]">
        [{ oxinputhelp ident="HELP_ARTICLE_MAIN_MPN" }]
      </td>
    </tr>

  <tr>
    <td class="edittext">
        [{ oxmultilang ident="ARTICLE_MAIN_SHORTDESC" }]&nbsp;
    </td>
    <td class="edittext">
        <textarea class="editinput" cols="30" rows="5" name="editval[oxarticles__oxshortdesc]" [{ $readonly }] >[{$edit->oxarticles__oxshortdesc->value}]</textarea>
        [{ oxinputhelp ident="HELP_ARTICLE_MAIN_SHORTDESC" }]
    </td>
  </tr>
  <tr>
    <td class="edittext">
        [{ oxmultilang ident="ARTICLE_MAIN_SEARCHKEYS" }]&nbsp;
    </td>
    <td class="edittext">
        <input type="text" class="editinput" size="32" maxlength="[{$edit->oxarticles__oxsearchkeys->fldmax_length}]" name="editval[oxarticles__oxsearchkeys]" value="[{$edit->oxarticles__oxsearchkeys->value}]" [{ $readonly }]>
        [{ oxinputhelp ident="HELP_ARTICLE_MAIN_SEARCHKEYS" }]
    </td>
  </tr>

  <tr>
    <td class="edittext">
      [{ oxmultilang ident="ARTICLE_MAIN_TAGS" }]&nbsp;
    </td>
    <td class="edittext">
      <input type="text" class="editinput" size="32" maxlength="255" name="editval[tags]" value="[{$edit->tags}]">
      [{ oxinputhelp ident="HELP_ARTICLE_MAIN_TAGS" }]
    </td>
  </tr>

  <tr>
    <td class="edittext">
        [{ oxmultilang ident="ARTICLE_MAIN_VENDORID" }]
    </td>
    <td class="edittext">
        <select class="editinput" name="editval[oxarticles__oxvendorid]" [{ $readonly }]>
        <option value="" selected>---</option>
        [{foreach from=$oView->getVendorList() item=oVendor}]
        <option value="[{$oVendor->oxvendor__oxid->value}]"[{if $edit->oxarticles__oxvendorid->value == $oVendor->oxvendor__oxid->value}] selected[{/if}]>[{ $oVendor->oxvendor__oxtitle->value }]</option>
        [{/foreach}]
        </select>
        [{ oxinputhelp ident="HELP_ARTICLE_MAIN_VENDORID" }]
    </td>
  </tr>

  <tr>
    <td class="edittext">
        [{ oxmultilang ident="ARTICLE_MAIN_MANUFACTURERID" }]
    </td>
    <td class="edittext">
        <select class="editinput" name="editval[oxarticles__oxmanufacturerid]" [{ $readonly }]>
        <option value="" selected>---</option>
        [{foreach from=$oView->getManufacturerList() item=oManufacturer }]
        <option value="[{$oManufacturer->oxmanufacturers__oxid->value}]"[{if $edit->oxarticles__oxmanufacturerid->value == $oManufacturer->oxmanufacturers__oxid->value}] selected[{/if}]>[{ $oManufacturer->oxmanufacturers__oxtitle->value }]</option>
        [{/foreach}]
        </select>
        [{ oxinputhelp ident="HELP_ARTICLE_MAIN_MANUFACTURERID" }]
    </td>
  </tr>
  
  <tr>
      <td class="edittext">
          [{ oxmultilang ident="MARM_TICKETCOUNT" }]
      </td>
      <td class="edittext">
        <input class="editinput" name="editval[oxarticles__marmticketcount]" value="[{$edit->oxarticles__marmticketcount->value}]">
        [{ oxinputhelp ident="HELP_ARTICLE_MAIN_MANUFACTURERID" }]
    </td>
  </tr>

  [{if !$edit->isParentNotBuyable()}]

    <tr>
      <td class="edittext">
        [{ oxmultilang ident="ARTICLE_MAIN_PRICE" }] ([{ $oActCur->sign }])
      </td>
      <td class="edittext">
        <input type="text" class="editinput" size="8" maxlength="[{$edit->oxarticles__oxprice->fldmax_length}]" name="editval[oxarticles__oxprice]" value="[{$edit->oxarticles__oxprice->value}]" [{ $readonly }]>
        &nbsp;<em>( [{$edit->getFPrice()}] )</em>
        [{ oxinputhelp ident="HELP_ARTICLE_MAIN_PRICE" }]
      </td>
    </tr>

  <tr>
    <td class="edittext">
    [{ oxmultilang ident="ARTICLE_MAIN_ALDPRICE" }] ([{ $oActCur->sign }])
    </td>
    <td class="edittext" nowrap>
        [{ oxmultilang ident="ARTICLE_MAIN_PRICEA" }] <input type="text" class="editinput" size="4" maxlength="[{$edit->oxarticles__oxpricea->fldmax_length}]" name="editval[oxarticles__oxpricea]" value="[{$edit->oxarticles__oxpricea->value}]" [{ $readonly }]>
        [{ oxmultilang ident="ARTICLE_MAIN_PRICEB" }] <input type="text" class="editinput" size="4" maxlength="[{$edit->oxarticles__oxpriceb->fldmax_length}]" name="editval[oxarticles__oxpriceb]" value="[{$edit->oxarticles__oxpriceb->value}]" [{ $readonly }]>
        [{ oxmultilang ident="ARTICLE_MAIN_PRICEC" }] <input type="text" class="editinput" size="4" maxlength="[{$edit->oxarticles__oxpricec->fldmax_length}]" name="editval[oxarticles__oxpricec]" value="[{$edit->oxarticles__oxpricec->value}]" [{ $readonly }]>
        [{ oxinputhelp ident="HELP_ARTICLE_MAIN_ALDPRICE" }]
    </td>
  </tr>
  <tr>
    <td class="edittext">
        [{ oxmultilang ident="ARTICLE_MAIN_VAT" }]
    </td>
    <td class="edittext">
        <input type="text" class="editinput" size="10" maxlength="[{$edit->oxarticles__oxvat->fldmax_length}]" name="editval[oxarticles__oxvat]" value="[{$edit->oxarticles__oxvat->value}]" [{include file="help.tpl" helpid=article_vat}] [{ $readonly }]>
        [{ oxinputhelp ident="HELP_ARTICLE_MAIN_VAT" }]
    </td>
  </tr>

  [{/if}]