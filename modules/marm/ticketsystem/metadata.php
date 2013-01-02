<?php

/**
 * This file is part of the Ticket module from marmalade.de
 *
 * It is not Open Source and may not be redistributed.
 * You can buy additional licences at http://www.marmalade.de/shop/
 *
 * Version:    1.0
 * Author:     Joscha Krug <krug@marmalade.de>
 * Author URI: http://www.marmalade.de
 */

/**
 * Metadata version
 */
$sMetadataVersion = '1.0';

/**
 * Module information
 */
$aModule = array(
    'id'            => 'marm/ticketsystem',
    'title'         => 'Ticketsystem based on OXID',
    'description'   => 'Basic ticketsystem for Barcamps',
    'version'       => '1.0',
    'author'        => 'marmalade.de',
    'url'           => 'http://www.marmalade.de',
    'email'         => 'support@marmalade.de',
    
    'extend'        => array(
        'oxbasket'  => 'marm/ticketsystem/application/model/marm_ticketsystem_oxbasket',
    ),
  
    'files'         => array(
    ),
    
    'templates'     => array(
    ),

    'blocks'        => array(
        array('template' => 'article_main.tpl', 'block' => 'admin_article_main_form', 'file' => 'admin_article_main_form.tpl'),
    ),
    
    'settings'      => array(
    ),
);