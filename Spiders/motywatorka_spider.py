import scrapy

class MotiSpider(scrapy.Spider):
        name = 'motywatorka'
        start_urls = ['https://motywatorka.pl/sklep/']

        def parse(self, response):
                for products in response.css('a.woocommerce-LoopProduct-link.woocommerce-loop-product__link'):
                    yield {
                        'name': products.css('h2.woocommerce-loop-product__title::text').get(),
                        'price': products.css('span.woocommerce-Price-amount.amount::text').get().replace('\xa0',''),
                        'link': products.css('a.woocommerce-LoopProduct-link.woocommerce-loop-product__link').attrib['href'],
                    }
