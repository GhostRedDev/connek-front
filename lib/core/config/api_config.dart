class ApiConfig {
  // Base URL for API - Heroku backend
  static const String baseUrl = 'https://connek-dev-aa5f5db19836.herokuapp.com';

  // Common headers for all requests
  static Map<String, String> get headers => {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Accept': 'application/json',
  };
}
