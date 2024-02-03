# generate data

from faker import Faker
from random import randint, uniform
from random import uniform
from random import choice

MAX_N = 1000


def generate_manufacturer():
    faker = Faker()
    f = open('Manufacturers.csv', 'w')
    for i in range(MAX_N):
        line = "{0};{1};{2};{3}\n".format(faker.name(), faker.country(), randint(1500, 2023), faker.hostname())
        f.write(line)
    f.close()


def generate_laptopmodel():
    faker = Faker()
    f = open('LaptopModels.csv', 'w')
    for i in range(MAX_N):
        line = "{0};{1};{2};{3};{4}\n".format(faker.name(), faker.name(), randint(1, 2000), round(uniform(1, 5), 2), randint(1, 100))
        f.write(line)
    f.close()


def generate_customer():
    faker = Faker()
    f = open('Customers.csv', 'w')
    for i in range(MAX_N):
        line = "{0};{1};{2};{3};{4};{5}\n".format(i + 1,faker.first_name(), faker.last_name(), faker.name(), faker.ascii_free_email(), faker.phone_number())
        f.write(line)
    f.close()


def generate_orders():
    faker = Faker()
    f = open('Orders.csv', 'w')
    for i in range(MAX_N):
        line = "{0};{1};{2};{3};{4};{5}\n".format(
                                            randint(1, 1000),
                                            randint(1, 1000),
                                            randint(1, 1000),
                                            faker.date(),
                                            randint(1, 2000),
                                            choice(["Pending", "Awaiting Payment", "Awaiting Fulfillment", "Awaiting Shipment", "Awaiting Pickup", "Completed", "Shipped", "Cancelled", "Declined", "Refunded"]))
        f.write(line)
    f.close()

generate_manufacturer()
generate_laptopmodel()
generate_customer()
generate_orders()

