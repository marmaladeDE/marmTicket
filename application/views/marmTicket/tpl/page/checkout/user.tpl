[{capture append="oxidBlock_content"}]
    [{assign var="template_title" value=""}]

    [{block name="checkout_user_main"}]
        [{include file="form/user_checkout_noregistration.tpl"}]
    [{/block}]
    [{insert name="oxid_tracker" title=$template_title }]
[{/capture}]

[{include file="layout/page.tpl"}]