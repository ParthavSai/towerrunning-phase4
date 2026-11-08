"""Read-only desktop/mobile browser audit; pip install playwright separately."""
import json
from pathlib import Path
from playwright.sync_api import sync_playwright


def main():
    routes=['/','/races','/athletes','/rankings','/records','/venues','/insights','/manage','/manage/operations','/nations','/nations?method=fastest&start=2025-01-01&end=2025-12-31','/rankings/publication/202512','/races/103/1','/athletes/1001']
    failures=[]
    with sync_playwright() as p:
        browser=p.chromium.launch(executable_path='/usr/bin/google-chrome',headless=True,args=['--no-sandbox'])
        for width,height in [(1440,1000),(390,844)]:
            page=browser.new_page(viewport={'width':width,'height':height})
            errors=[]
            page.on('pageerror',lambda error:errors.append(str(error)))
            for route in routes:
                response=page.goto('http://127.0.0.1:5055'+route,wait_until='networkidle')
                if response.status!=200:failures.append((width,route,'HTTP '+str(response.status)))
                overflow=page.evaluate('document.documentElement.scrollWidth>innerWidth+1')
                if overflow:
                    bad=page.evaluate("Array.from(document.querySelectorAll('body *')).filter(e=>e.getBoundingClientRect().right>innerWidth+2 && getComputedStyle(e).position!=='absolute').slice(0,8).map(e=>e.tagName+'.'+e.className)")
                    failures.append((width,route,'horizontal overflow',bad))
                if route in ['/','/manage/operations','/nations','/insights']:
                    page.screenshot(path=f'/tmp/towerrunning-{width}-{route.strip("/").replace("/","-") or "home"}.png',full_page=True)
            if width==390:
                page.goto('http://127.0.0.1:5055/')
                page.click('#menu-toggle')
                assert page.get_attribute('#menu-toggle','aria-expanded')=='true'
                assert page.locator('#main-nav').is_visible()
            if errors:failures.append(('javascript',errors))
            page.close()
        browser.close()
    print(json.dumps(failures,indent=2))
    if failures:raise SystemExit(1)
    print('PASS: 14 routes at desktop/mobile sizes, no document overflow or JavaScript errors; mobile navigation works.')

if __name__=='__main__':main()
