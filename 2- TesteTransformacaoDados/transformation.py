import os
import zipfile

import pandas as pd
import tabula


def create_csv_file(path_csv: str):
    folder_pdfs_anexo_1 = './1-TesteWebScrapping/pdf-files/anexo_1.pdf'

    tabula.convert_into(folder_pdfs_anexo_1,
                        path_csv,
                        output_format='csv', pages='3-181')


def transform_data(path_csv: str) -> pd.DataFrame:

    df = pd.read_csv(path_csv)

    df.columns = [col.replace('\r', " ") for col in df.columns]

    df = df.rename(columns={'OD': 'Seg. Odontológica',
                            'AMB': 'Seg. Ambulatorial'})
    return df


def zip_files(original_folder, zip_file, file_name):
    with zipfile.ZipFile(zip_file, 'w') as zipf:
        for file in os.listdir(original_folder):
            if file == file_name:
                full_path = os.path.join(original_folder, file)

                zipf.write(full_path, file)

                print(f'{zip_file} created')


if __name__ == '__main__':
    destination_folder = './2- TesteTransformacaoDados/pdf_to_csv'
    path_csv = f'{destination_folder}/table_rol.csv'

    os.makedirs(destination_folder, exist_ok=True)

    create_csv_file(path_csv)

    df = transform_data(path_csv)

    df.to_csv(f'{destination_folder}/transformed_csv.csv')

    zip_files(destination_folder, f'{destination_folder}/Teste_Guilherme.zip',
              'transformed_csv.csv')
