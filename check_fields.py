import json

with open('openapi.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

path = '/employees/greg/business/{business_id}'
schema_ref = data['paths'][path]['put']['requestBody']['content']['application/x-www-form-urlencoded']['schema']['$ref']
schema_name = schema_ref.split('/')[-1]
schema = data['components']['schemas'][schema_name]
props = schema['properties']

for target in ['custom_policies', 'excluded_phones', 'library', 'blacklist', 'procedures', 'accepted_payment_methods', 'information_not_to_share', 'procedures_details', 'post_booking_procedures', 'cancellation_documents']:


    with open(f"prop_{target}.json", "w") as f:
        if target in props:
            json.dump(props[target], f, indent=2)
        else:
            f.write("NOT FOUND")

