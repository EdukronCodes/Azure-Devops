#!/usr/bin/env python3
"""
Production Tests Script
Runs comprehensive tests against the production environment
"""

import requests
import json
import sys
import time
from typing import Dict, List, Any

class ProductionTester:
    def __init__(self, base_url: str):
        self.base_url = base_url.rstrip('/')
        self.session = requests.Session()
        self.session.timeout = 30
        
    def test_health_endpoint(self) -> bool:
        """Test basic health endpoint"""
        try:
            response = self.session.get(f"{self.base_url}/health")
            return response.status_code == 200
        except Exception as e:
            print(f"Health endpoint test failed: {e}")
            return False
    
    def test_api_health(self) -> bool:
        """Test API health endpoint"""
        try:
            response = self.session.get(f"{self.base_url}/api/health")
            return response.status_code == 200
        except Exception as e:
            print(f"API health endpoint test failed: {e}")
            return False
    
    def test_database_connection(self) -> bool:
        """Test database connectivity"""
        try:
            response = self.session.get(f"{self.base_url}/api/health/database")
            return response.status_code == 200
        except Exception as e:
            print(f"Database connection test failed: {e}")
            return False
    
    def test_redis_connection(self) -> bool:
        """Test Redis connectivity"""
        try:
            response = self.session.get(f"{self.base_url}/api/health/redis")
            return response.status_code == 200
        except Exception as e:
            print(f"Redis connection test failed: {e}")
            return False
    
    def test_critical_endpoints(self) -> List[Dict[str, Any]]:
        """Test critical application endpoints"""
        endpoints = [
            {"path": "/api/users", "method": "GET", "expected_status": [200, 401]},
            {"path": "/api/auth/login", "method": "POST", "expected_status": [400, 422]},
            {"path": "/api/config", "method": "GET", "expected_status": [200, 401]},
        ]
        
        results = []
        for endpoint in endpoints:
            try:
                if endpoint["method"] == "GET":
                    response = self.session.get(f"{self.base_url}{endpoint['path']}")
                else:
                    response = self.session.post(f"{self.base_url}{endpoint['path']}", json={})
                
                success = response.status_code in endpoint["expected_status"]
                results.append({
                    "endpoint": endpoint["path"],
                    "status_code": response.status_code,
                    "success": success,
                    "response_time": response.elapsed.total_seconds()
                })
                
                if not success:
                    print(f"Endpoint {endpoint['path']} failed: {response.status_code}")
                    
            except Exception as e:
                results.append({
                    "endpoint": endpoint["path"],
                    "status_code": None,
                    "success": False,
                    "error": str(e)
                })
                print(f"Endpoint {endpoint['path']} error: {e}")
        
        return results
    
    def test_performance(self) -> Dict[str, Any]:
        """Test basic performance metrics"""
        performance_tests = []
        
        # Test response times for key endpoints
        endpoints_to_test = ["/health", "/api/health"]
        
        for endpoint in endpoints_to_test:
            times = []
            for _ in range(5):  # Test 5 times
                try:
                    start_time = time.time()
                    response = self.session.get(f"{self.base_url}{endpoint}")
                    end_time = time.time()
                    
                    if response.status_code == 200:
                        times.append(end_time - start_time)
                except Exception as e:
                    print(f"Performance test failed for {endpoint}: {e}")
            
            if times:
                performance_tests.append({
                    "endpoint": endpoint,
                    "avg_response_time": sum(times) / len(times),
                    "max_response_time": max(times),
                    "min_response_time": min(times),
                    "success_rate": len(times) / 5
                })
        
        return {
            "performance_tests": performance_tests,
            "overall_avg_response_time": sum([t["avg_response_time"] for t in performance_tests]) / len(performance_tests) if performance_tests else 0
        }
    
    def run_all_tests(self) -> Dict[str, Any]:
        """Run all production tests"""
        print("Starting production tests...")
        
        results = {
            "health_endpoint": self.test_health_endpoint(),
            "api_health": self.test_api_health(),
            "database_connection": self.test_database_connection(),
            "redis_connection": self.test_redis_connection(),
            "critical_endpoints": self.test_critical_endpoints(),
            "performance": self.test_performance()
        }
        
        # Calculate overall success
        critical_tests = [
            results["health_endpoint"],
            results["api_health"],
            results["database_connection"]
        ]
        
        results["overall_success"] = all(critical_tests)
        
        return results

def main():
    import argparse
    
    parser = argparse.ArgumentParser(description="Run production tests")
    parser.add_argument("--url", default="https://your-app.azurewebsites.net", 
                       help="Base URL of the production application")
    parser.add_argument("--verbose", action="store_true", help="Verbose output")
    
    args = parser.parse_args()
    
    tester = ProductionTester(args.url)
    results = tester.run_all_tests()
    
    print("\n" + "="*50)
    print("PRODUCTION TEST RESULTS")
    print("="*50)
    
    print(f"Health Endpoint: {'✅ PASS' if results['health_endpoint'] else '❌ FAIL'}")
    print(f"API Health: {'✅ PASS' if results['api_health'] else '❌ FAIL'}")
    print(f"Database Connection: {'✅ PASS' if results['database_connection'] else '❌ FAIL'}")
    print(f"Redis Connection: {'✅ PASS' if results['redis_connection'] else '❌ FAIL'}")
    
    print("\nCritical Endpoints:")
    for endpoint_result in results["critical_endpoints"]:
        status = "✅ PASS" if endpoint_result["success"] else "❌ FAIL"
        print(f"  {endpoint_result['endpoint']}: {status} ({endpoint_result['status_code']})")
    
    print(f"\nPerformance:")
    for perf_test in results["performance"]["performance_tests"]:
        print(f"  {perf_test['endpoint']}: {perf_test['avg_response_time']:.3f}s avg")
    
    print(f"\nOverall Result: {'✅ ALL TESTS PASSED' if results['overall_success'] else '❌ SOME TESTS FAILED'}")
    
    if args.verbose:
        print("\nDetailed Results:")
        print(json.dumps(results, indent=2))
    
    # Exit with appropriate code
    sys.exit(0 if results["overall_success"] else 1)

if __name__ == "__main__":
    main()
