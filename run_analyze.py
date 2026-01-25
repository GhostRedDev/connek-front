
import subprocess
import sys

def run_analyze():
    try:
        result = subprocess.run(
            ['dart', 'analyze', 'lib/features/business/lead_details_page.dart'],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            encoding='utf-8' 
        )
        with open('analysis_result.txt', 'w', encoding='utf-8') as f:
            f.write(result.stdout)
            f.write(result.stderr)
        print("Analysis finished. Output saved to analysis_result.txt")
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    run_analyze()
