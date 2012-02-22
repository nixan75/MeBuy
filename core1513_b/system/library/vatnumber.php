<?php

/**
 * Some minor changes - remove spaces and dots
 * @author Massimo Di Marzo <dimarzom at gmail.com>
 * OC Port of PS vatnumber module
 * @author maks feltrin - feliks  <maks.feltrin at gmail.com>
 * 
 * ORIGINAL AUTHOR & LICENSE
 * @author PrestaShop SA <contact@prestashop.com>
 * @copyright  2007-2011 PrestaShop SA
 * @version  Release: $Revision: 1.4 $
 * @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
 * International Registered Trademark & Property of PrestaShop SA
 */
class vatnumber 
{
	public static function getIntracomVATPrefixes()
	{
		$prefixes = array(
			'AT'=>'AT',	//Austria
			'BE'=>'BE',	//Belgium
			'DK'=>'DK',	//Denmark
			'FI'=>'FI',	//Finland
			'FR'=>'FR',	//France
			'FX'=>'FR',	//France métropolitaine
			'DE'=>'DE',	//Germany
			'GR'=>'EL',	//Greece
			'IE'=>'IE',	//Irland
			'IT'=>'IT',	//Italy
			'LU'=>'LU',	//Luxembourg
			'NL'=>'NL',	//Netherlands
			'PT'=>'PT',	//Portugal
			'ES'=>'ES',	//Spain
			'SE'=>'SE',	//Sweden
			'GB'=>'GB',	//United Kingdom
			'CY'=>'CY',	//Cyprus
			'EE'=>'EE',	//Estonia
			'HU'=>'HU',	//Hungary
			'LV'=>'LV',	//Latvia
			'LT'=>'LT',	//Lithuania
			'MT'=>'MT',	//Malta
			'PL'=>'PL',	//Poland
			'SK'=>'SK',	//Slovakia
			'CZ'=>'CZ',	//Czech Republic
			'SI'=>'SI',	//Slovenia
			'RO'=>'RO', //Romania
			'BG'=>'BG'	//Bulgaria
		);
		return $prefixes;
	}

	public static function isApplicable($country_iso2)
	{
    return in_array($country_iso2, self::getIntracomVATPrefixes());
	}

// madimar - added argument $country_prefix for VAT prefix rebuild if missing	
	public static function check($vatnum, $country_prefix=NULL, $allowEmpty=false)
	{
		if (empty($vatnum) and $allowEmpty)
		{
			return 1;
		}	
		elseif (empty($vatnum))
		{
			return 0;
		}	
    
// madimar		$vatnum = str_replace(' ', '', $vatnum);
// madimar preg_replace to remove recurring zeros, tabs, dots, etc.
		$vatnum = preg_replace('/[\.\s*]/m', '', $vatnum);

		$prefix = substr($vatnum, 0, 2);
		
// VAT prefix rebuild if missing
		if (!array_search($prefix, self::getIntracomVATPrefixes()) && isset($country_prefix) ) // prefix is not in vatnum but country_prefix has been passed by the calling function
		{	
			$prefix = $country_prefix;
			$vat = $vatnum;
		}	
		else if (preg_match('/^[A-Za-z]/', $prefix) )
		{	
			$vat = substr($vatnum, 2);				
		}	
		else
		{		
			return 0;
		}			
// VAT prefix check with Intracom array	and $country_prefix if any
		if (array_search($prefix, self::getIntracomVATPrefixes()) === false && !(isset($country_prefix) && ($prefix != $country_prefix)))
			return 0;
		
		$url = 'http://ec.europa.eu/taxation_customs/vies/viesquer.do?ms='.urlencode($prefix).'&iso='.urlencode($prefix).'&vat='.urlencode($vat);
		@ini_set('default_socket_timeout', 2);
		for ($i = 0; $i < 3; $i++)
		{
// modified with curl
			if ($pageRes = self::curl($url))
			{
				if (preg_match('/invalid VAT number/i', $pageRes))
				{
					@ini_restore('default_socket_timeout');
					return 0;
				}
				else if (preg_match('/valid VAT number/i', $pageRes))
				{
					@ini_restore('default_socket_timeout');
					return 1;
				}
				else
				{
					++$i;
				}	
			}
			else
			{
				sleep(1);
			}	
		}
		ini_restore('default_socket_timeout');
	
		$vatOK = -1;

// madimar - in case of VIES unavailability try to check with algorithm - only for Italy and Spain		
		if ($vatOK == -1 && $prefix=='IT') 
			return self::checkPiva($vat);	

		if ($vatOK == -1 && $prefix=='ES') 
		{
			$cifOK = self::valida_nif_cif_nie($vat);
			if ($cifOK = 2)
			{
				return 1;
			}	
			else
			{
			return 0;
			}
		}
		return $vatOK;
	}

  public static function checkPiva($piva) 
  {
    // FAST CHECK
    if (strlen($piva) != 11)
      return 0;
    
    // FAST CHECK
    if (!preg_match("/^[0-9]+$/", $piva))
      return 0;
    
    // COMPLETE CHECK
		for( $x=0, $i=0; $i<11; $i+=2 )
			$x += (int)( substr( $piva, $i, 1 ) );
		
    for( $y=0, $z=0, $i=1; $i<11; $i+=2 )
    {
			$n = (int)substr( $piva, $i, 1 );
			$y += $n<<1;
			if( $n>=5 )
				$z++;
    }
		$t = ( $x + $y + $z ) % 10;
    if( $t !== 0 )  
      return 0;
    
    return 1;
  }
  
  public static function checkCF($cf)
  {
    return preg_match('/^[a-zA-Z]{6}[0-9]{2}[a-zA-Z]{1}[0-9]{2}[a-zA-Z]{1}[0-9]{3}[a-zA-Z]{1}$/i', $cf);
  }
  
public static function valida_nif_cif_nie($cif) {
//Copyright 2005-2011 David Vidal Serra. Bajo licencia GNU GPL.
//Este software viene SIN NINGUN TIPO DE GARANTIA; para saber mas detalles
//puede consultar la licencia en http://www.gnu.org/licenses/gpl.txt(1)
//Esto es software libre, y puede ser usado y redistribuirdo de acuerdo
//con la condicion de que el autor jamas sera responsable de su uso.
//Returns: 1 = NIF ok, 2 = CIF ok, 3 = NIE ok, -1 = NIF bad, -2 = CIF bad, -3 = NIE bad, 0 = ??? bad
         $cif = strtoupper($cif);
         for ($i = 0; $i < 9; $i ++)
         {
                  $num[$i] = substr($cif, $i, 1);
         }
//si no tiene un formato valido devuelve error
         if (!preg_match('/((^[A-Z]{1}[0-9]{7}[A-Z0-9]{1}$|^[T]{1}[A-Z0-9]{8}$)|^[0-9]{8}[A-Z]{1}$)/', $cif))
         {
                  return 0;
         }
//comprobacion de NIFs estandar
         if (preg_match('/(^[0-9]{8}[A-Z]{1}$)/', $cif))
         {
                  if ($num[8] == substr('TRWAGMYFPDXBNJZSQVHLCKE', substr($cif, 0, 8) % 23, 1))
                  {
                           return 1;
                  }
                  else
                  {
                           return -1;
                  }
         }
//algoritmo para comprobacion de codigos tipo CIF
         $suma = $num[2] + $num[4] + $num[6];
         for ($i = 1; $i < 8; $i += 2)
         {
                  $suma += substr((2 * $num[$i]),0,1) + substr((2 * $num[$i]), 1, 1);
         }
         $n = 10 - substr($suma, strlen($suma) - 1, 1);
//comprobacion de NIFs especiales (se calculan como CIFs o como NIFs)
         if (preg_match('/^[KLM]{1}/', $cif))
         {
                  if ($num[8] == chr(64 + $n) || $num[8] == substr('TRWAGMYFPDXBNJZSQVHLCKE', substr($cif, 1, 8) % 23, 1))
                  {
                           return 1;
                  }
                  else
                  {
                           return -1;
                  }
         }
//comprobacion de CIFs
         if (preg_match('/^[ABCDEFGHJNPQRSUVW]{1}/', $cif))
         {
                  if ($num[8] == chr(64 + $n) || $num[8] == substr($n, strlen($n) - 1, 1))
                  {
                           return 2;
                  }
                  else
                  {
                           return -2;
                  }
         }
//comprobacion de NIEs
//T
         if (preg_match('/^[T]{1}/', $cif))
         {
                  if ($num[8] == preg_match('/^[T]{1}[A-Z0-9]{8}$/', $cif))
                  {
                           return 3;
                  }
                  else
                  {
                           return -3;
                  }
         }
//XYZ
         if (preg_match('/^[XYZ]{1}/', $cif))
         {
                  if ($num[8] == substr('TRWAGMYFPDXBNJZSQVHLCKE', substr(str_replace(array('X','Y','Z'), array('0','1','2'), $cif), 0, 8) % 23, 1))
                  {
                           return 3;
                  }
                  else
                  {
                           return -3;
                  }
         }
//si todavia no se ha verificado devuelve error
         return 0;
}

public static function curl($url){
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL, $url);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
	curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);	// added to solve redirection issues
	$data = curl_exec($ch);
	curl_close($ch);
	return $data;
	}  
  
  
}

