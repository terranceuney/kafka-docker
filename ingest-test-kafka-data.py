from confluent_kafka.admin import AdminClient, NewTopic
import json
import time
import os

kafka_broker = f"kafka:9092"
topic_name = 'test-topic'

conf = {
    'bootstrap.servers': kafka_broker,
    'security.protocol': 'SASL_PLAINTEXT', 
    'sasl.mechanism': 'GSSAPI',  
    'sasl.kerberos.service.name': 'kafka-broker',
    'sasl.kerberos.principal': 'kafka-producer@UNEY.COM',
    'sasl.kerberos.keytab': '/etc/security/keytabs/kafka-producer.keytab', 
}

admin_client = AdminClient(conf)
new_topic = NewTopic(topic_name, num_partitions=1, replication_factor=1)

fs = admin_client.create_topics([new_topic])
for topic, f in fs.items():
    try:
        f.result()  # The result itself is None
        print("Topic {} created".format(topic))
    except Exception as e:
        print("Failed to create topic {}: {}".format(topic, e))


# producer = KafkaProducer(
#     bootstrap_servers=[kafka_broker], 
#     security_protocol = 'SASL_PLAINTEXT',
#     sasl_mechanism='GSSAPI',
#     sasl_kerberos_service_name='kafka', 
#     # sasl_kerberos_principal='kafka-producer/kafka@UNEY.COM',
#     # sasl_kerberos_keytab='/etc/security/keytabs/kafka-producer.keytab',  
#     value_serializer=lambda v: json.dumps(v).encode('utf-8')
# )

# data_list = [
#     { "id": "txn_98766", "amount": 251.75, "currency": "USD", "status": "completed", "sys_date": "20240825" },
#     { "id": "txn_98767", "amount": 252.75, "currency": "AED", "status": "completed", "sys_date": "20240825" },
#     { "id": "txn_98768", "amount": 253.75, "currency": "SGD", "status": "rejected", "sys_date": "20240825" },
#     { "id": "txn_98769", "amount": 254.75, "currency": "USD", "status": "completed", "sys_date": "20240825" },
#     { "id": "txn_98770", "amount": 255.75, "currency": "USD", "status": "pending", "sys_date": "20240825" },
#     { "id": "txn_98771", "amount": 256.75, "currency": "USD", "status": "completed", "sys_date": "20240825" },
#     { "id": "txn_98772", "amount": 257.75, "currency": "USD", "status": "completed", "sys_date": "20240825" },
#     { "id": "txn_98773", "amount": 258.75, "currency": "SGD", "status": "pending", "sys_date": "20240825" },
#     { "id": "txn_98774", "amount": 259.75, "currency": "AED", "status": "completed", "sys_date": "20240826" },
#     { "id": "txn_98765", "amount": 250.75, "currency": "USD", "status": "completed", "sys_date": "20240826" },
#     { "id": "txn_98766", "amount": 251.75, "currency": "USD", "status": "pending", "sys_date": "20240826" },
#     { "id": "txn_98767", "amount": 252.75, "currency": "USD", "status": "completed", "sys_date": "20240826" },
#     { "id": "txn_98768", "amount": 253.75, "currency": "USD", "status": "rejected", "sys_date": "20240826" },
#     { "id": "txn_98769", "amount": 254.75, "currency": "USD", "status": "completed", "sys_date": "20240826" },
#     { "id": "txn_98770", "amount": 255.75, "currency": "SGD", "status": "completed", "sys_date": "20240827" },
#     { "id": "txn_98766", "amount": 251.75, "currency": "AED", "status": "rejected", "sys_date": "20240827" },
#     { "id": "txn_98767", "amount": 252.75, "currency": "USD", "status": "completed", "sys_date": "20240827" },
#     { "id": "txn_98768", "amount": 253.75, "currency": "USD", "status": "rejected", "sys_date": "20240827" },
#     { "id": "txn_98769", "amount": 254.75, "currency": "USD", "status": "pending", "sys_date": "20240827" },
#     { "id": "txn_98770", "amount": 255.75, "currency": "AED", "status": "rejected", "sys_date": "20240827" },
#     { "id": "txn_98771", "amount": 256.75, "currency": "USD", "status": "completed", "sys_date": "20240827" },
#     { "id": "txn_98772", "amount": 257.75, "currency": "USD", "status": "completed", "sys_date": "20240827" },
#     { "id": "txn_98773", "amount": 258.75, "currency": "USD", "status": "pending", "sys_date": "20240827" },
#     { "id": "txn_98774", "amount": 259.75, "currency": "USD", "status": "rejected", "sys_date": "20240828" },
#     { "id": "txn_98765", "amount": 250.75, "currency": "USD", "status": "completed", "sys_date": "20240828" },
#     { "id": "txn_98766", "amount": 251.75, "currency": "SGD", "status": "completed", "sys_date": "20240828" },
#     { "id": "txn_98767", "amount": 252.75, "currency": "USD", "status": "completed", "sys_date": "20240828" },
#     { "id": "txn_98768", "amount": 253.75, "currency": "AED", "status": "rejected", "sys_date": "20240828" },
#     { "id": "txn_98769", "amount": 254.75, "currency": "USD", "status": "completed", "sys_date": "20240828" },
#     { "id": "txn_98770", "amount": 255.75, "currency": "USD", "status": "pending", "sys_date": "20240828" }
# ]

# for data in data_list:
#     print(f'sending: {data}')
#     producer.send('test-topic', value=data)

# producer.flush()
# producer.close()

# print("Message sent successfully")