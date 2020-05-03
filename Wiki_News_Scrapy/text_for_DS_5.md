I this task we had to make a web crawler that could scrape information from "Politics and Conflict" on Wikinews and based on our group number we would should only select a subset of all articles. This was given to us in the form of some python code to generate a string with the beginning letter for articles within our subset of articles.

The first step we took was to figure out what kind of task we were given before we decided on a given tool.

The first few observations we made were regarding how the webpage indexed its articles such that we could make our crawling logic.

The first observation we made was that each "entry point" for a given letter was easy to get as it was just https://en.wikinews.org/w/index.php?title=Category:Politics_and_conflicts&from=[letter], where the letter was at the end of the url. on a given entry point there are links to categories and articles however there are a maximum 200 pages, even if there are more articles with a given starting letter, so we had to follow links to find all articles. A stiking(maybe wrong word) point arose when we looked at "indexing"-urls after our entry points as they had no information of what letter/entry point we were coming from as they where of the form https://en.wikinews.org/w/index.php?title=Category:Politics_and_conflicts&pagefrom=[start article]+[end article], such that the url only described by article tiles what other articles where on that indexing page. This mean that our tool had to be able to follow links and have knowledge of what page it was coming from as it could nut just use information on a page as well as jumping to all articles on an indexing page.

next we looked at a few articles and they seemed to have a general structure such that locating them on a page within html would be somewhat doable so we postponed the actual scraping part for later.

Because of the requirements based on our initial exploration of the problem(might be bad wording) and our look at python web scraping tools we choose Scrapy as it is a feature rich tool made for making web crawlers and as we had some requirements that where non trivial ie. traversal logic more complicated then get all links and so on we choose it.

When implementing our scraper we had a lot obstacles a long the way aplified by the fact that we assigned tasks such that people with less explerience i an given subject had to do it for our assignment.

We started by reading documentation while watching and reading tutorials as we building a dummy spider for a smaller part of the problem to get the basics of Scrapy right as well as understading HTML-markup node navigation. we made use of xpath to locate nodes within HTML. A snapshot of our Scrapy class we made is given below:

``` bash
class testSpider(scrapy.Spider):
    name = "test"
    def start_requests(self):
        urls = [
            'https://en.wikinews.org/wiki/A_policeman_is_killed_and_another_one_is_tortured_in_MST_camp,_in_Brazil',

            'https://en.wikinews.org/wiki/African_Union_refuses_to_arrest_Sudan%27s_President_for_war_crimes',
        ]
        for url in urls:
            yield scrapy.Request(url=url, callback=self.parse)

    # get article content
    def parse(self, response):
        for info in response.xpath('//div[@id="content"]'):
            yield {
                'title': info.xpath('//*[@id="firstHeading"]/text()').get(),
            }
```
This test spider was used to see of we could iterate over a list of article-urls if we could locate them on a navigation page. This early spider has 2 parts only, one for iterating over urls and the other for getting article scraping data. The spider above worked fine but the next step being creating the navigation logic became the biggest hurdle caused by a simple ting. We wrote the spider logic for another website as it was simpler and adapted it to wikinews, however when we interchanged our other website with wikinews no files where generated when we selected to get output. After debugging we stumpled(wrong word?) into an Error about robot.txt which tunrns out is used when accesing websites from non-intruductionary-tutorials as it is a policy obayed by all never Scrapy spider by default if a website dosen't allow certain kinds of scrapers. After this we changed our spider to not obay the robot.txt but read https://en.wikipedia.org/robots.txt and implimented restrictions on the spider as to not be more fair to the website as we. Below are some of the settings we enabled to scrape responibly:

``` python
AUTOTHROTTLE_ENABLED = True
# The initial download delay
AUTOTHROTTLE_START_DELAY = 5
# The maximum download delay to be set in case of high latencies
AUTOTHROTTLE_MAX_DELAY = 30
# The average number of requests Scrapy should be sending in parallel to
# each remote server
AUTOTHROTTLE_TARGET_CONCURRENCY = 1.0
# Enable showing throttling stats for every response received:

# Enable and configure HTTP caching (disabled by default)
HTTPCACHE_ENABLED = True
```

Our final spider became somewhat complicated for a first spider crawls without much of a problem.


``` python
import string
import re
import scrapy
from scrapy.loader import ItemLoader
from scrapy.loader.processors import Join, Compose
from datetime import datetime
from urllib.parse import urljoin
from ..items import articleItem # location of item - used for scraped data structure

# creating urls for chars based on group _nr - change group_nr to generate start_urls
group_nr = 12 # <- change to get correct article set
urls =[]
for char in "ABCDEFGHIJKLMNOPRSTUVWZABCDEFGHIJKLMNOPRSTUVWZ"[group_nr % 23:group_nr % 23+10]:
    urls.append('https://en.wikinews.org/w/index.php?title=Category:Politics_and_conflicts&from=' + char)
print(*urls, sep='\n')

# main spider
class wikiSpider(scrapy.Spider):
    name = "wiki"

    # start urls for scraping
    def start_requests(self):

        # urls used to spawn spider-instances
        global urls
        for url in urls:
            yield scrapy.Request(url=url, callback=self.parse)

    # Set the maximum depth
    maxdepth = 10

    def parse(self, response):
        """ Main method that parse downloaded pages. """
        # Set defaults for the first page that won't have any meta information
        start_url = ''
        from_url = ''
        from_text = ''
        depth = 0
        # Extract the meta information from the response, if any
        if 'start'  in response.meta: start_url = response.meta['start']
        if 'from'   in response.meta: from_url  = response.meta['from']
        if 'text'   in response.meta: from_text = response.meta['text']
        if 'depth'  in response.meta: depth     = response.meta['depth']
        
        # set start url for crawler
        if depth == 0:
            start_url = response.url

        # get all article links
        if start_url[-1] == response.xpath('//div[@id="mw-pages"]/div/div/div[1]/h3/text()').get(): # chek that current letter is on page

            # change xpath to: ('//div[@id="mw-pages"]/div/div/div[1]/ul/li[1]/a/@href') <- 1   page
            # change xpath to: ('//div[@id="mw-pages"]/div/div/div[1]/ul/li/a/@href')    <- 200 pages
            articles = response.xpath('//div[@id="mw-pages"]/div/div/div[1]/ul/li/a/@href').getall()
            for a in articles:
                url = urljoin(response.url, a)
                yield scrapy.Request(url, callback=self.parse_article)

        ### DEBUG printing - used for locating spider behavior ###
        print("### DEBUG DUMP STEP:", depth, response.url, '<-', from_url, from_text, "END ###",
              "### DEBUG DUMP start_url:", start_url[-1], response.xpath('//div[@id="mw-pages"]/div/div/div[1]/h3/text()').get(),"char_page END ###")

        # get nex_page only if maximum depth has not be reached and current char is still on page
        if depth < self.maxdepth and start_url[-1] == response.xpath('//div[@id="mw-pages"]/div/div/div[1]/h3/text()').get():
            next_page = response.xpath('//div[@id="mw-pages"]/a[2]') # location of next link
            next_page_text = next_page.xpath("text()").get()
            next_page_link = next_page.xpath("@href").get()
            print("### DEBUG DUMP next_page:", next_page, "END ###")

            if next_page_link is not None:
                request = response.follow(next_page_link, callback=self.parse)
                # Meta information: URL of the current page
                request.meta['from'] = response.url
                # Meta information: text of the link
                request.meta['text'] = next_page_text
                # Meta information: depth of the link
                request.meta['depth'] = depth + 1
                # Meta information: start page for current crawler
                request.meta['start'] = start_url
                yield request

    # get article content - using scrapy itemLoader and Items
    def parse_article(self, response):
        l = ItemLoader(item=articleItem(), response=response) # create itemloader l - following is adding to Fields
        l.add_xpath('title',        '//*[@id="firstHeading"]/text()')
        l.add_xpath('publish_date', '//div[@id="catlinks"]/div[@id="mw-normal-catlinks"]/ul/li/a/text()',re='(?:Jan(?:uary)?|Feb(?:ruary)?|Mar(?:ch)?|Apr(?:il)?|May|Jun(?:e)?|Jul(?:y)?|Aug(?:ust)?|Sep(?:tember)?|Oct(?:ober)?|Nov(?:ember)?|Dec(?:ember)?)[\s,]*(?:\d{1,2})[\s,]*(?:\d{4})')
        l.add_xpath('content',      '//div[@id="mw-content-text"]/div[@class="mw-parser-output"]/p/text()|//div[@id="mw-content-text"]/div[@class="mw-parser-output"]/p/child::a/text()|//div[@id="mw-content-text"]/div[@class="mw-parser-output"]/ul/li/text()', Join(' '))
        l.add_xpath('categories',   '//div[@id="catlinks"]/div[@id="mw-normal-catlinks"]/ul/li/a/text()')
        l.add_xpath('sources_url',  '//div[@id="mw-content-text"]/div[@class="mw-parser-output"]/ul/li/span/a/@href')
        l.add_xpath('about_sources_wiki_url', '//div[@id="mw-content-text"]/div[@class="mw-parser-output"]/ul/li/span/i/span/a/@href')
        l.add_value('article_url', response.request.url)
        l.add_value('scraped_at', (datetime.today().strftime('%Y-%m-%d')) )
        yield l.load_item() # could use return/yield - no idea what changesw
```

The general idea for the final Spider is that we generate based on group_nr our entry-point websites and generate a list of all article urls to follow afterwards we follow all these links we follow a link to the next 200 link-page and start again. By using metadata parameters we can inform the spider about where it has been where it is going as well as its root url/entry point and how deep it has gone. The last part about the spider to talk about is the parse_article(function?) where we make use of scrapys item containers wich help us deal with missing data in the case of a broken link or other unforeseen things.

The datafeilds we ended up collecting were:
* 'article_url'
* 'title' = title of the article inside the page
* 'categories' = categories assigned to the article
* 'content' = main text of article
* 'publish_date'
* 'scraped_at' = date of scraping by our spider
* 'sources_url' = urls for all individual pages used as a source
* 'about_sources_wiki_url' = url to wikipage about a given source ie. BBC

We felt that these would be of use for further analyses for another group as well as being general enough that most articles would have an entry for all fields.



