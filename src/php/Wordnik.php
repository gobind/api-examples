<?
/**
 * This is a simple interface to the api. Curl's requests, loads data
 *
 * @author Wordnik
 *
 */

// to get an array of definition objects, do something like this:
// $definitions = Wordnik::instance()->getDefinitions('donkey');

class Wordnik {
	
	// if there's an existing instance, return it, otherwise create and return a new one
	private static $instance;
	public static function instance() {
		if (self::$instance == NULL) {
			self::$instance = new Wordnik();
		}
		
		return self::$instance;
	}
	
	// utility method to call json apis.
	// this presumes you want JSON back; could be adapted for XML pretty easily
	private function curlData($uri) {
		$data = null;
		
		$curl_headers = array();
		$curl_headers[] = "Accept: application/json";
		$curl_headers[] = "api_key: YOUR_API_KEY_HERE";

		$curl = curl_init();
		curl_setopt($curl, CURLOPT_TIMEOUT, 5); // 5 second timeout
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_HTTPHEADER, $curl_headers);
		curl_setopt ($curl, CURLOPT_URL, $uri);
		
		$response = curl_exec($curl);
		$response_info = curl_getinfo($curl);
		
		if ($response_info['http_code'] == 0) {
			throw new Exception( "TIMEOUT: curlData Api call to " . $uri . " took more than 5s to return" );
		} else if ($response_info['http_code'] == 200) {
			$data = json_decode($response);
		} else if ($response_info['http_code'] == 404) {
			$data = null;
		} else {
			throw new Exception("Can't connect to the api: " . $uri . " response code: " . $response_info['http_code']);
		}

		return $data;
	}
	
	// pass in a word, get back an array of definitions
	public function getDefinitions($word) {
		if(is_null($word) || trim($word) == '') {
			throw new InvalidParameterException("definitions expects word to be a string");
		}
		
		return $this->curlData( 'http://beta.wordnik.com/admin/api/word.json/' . rawurlencode($word) . '/definitions' );
	}
	
}