import os
import zipfile

import requests
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from tqdm import tqdm


def access_site(url: str) -> tuple:

    chrome_options = Options()

    driver = webdriver.Chrome(options=chrome_options)

    driver.get(url)

    try:

        pdf_links = driver.find_elements(By.CLASS_NAME, 'internal-link')

        download_links = (pdf_links[0].get_attribute('href'),
                          pdf_links[2].get_attribute('href'))

        return download_links

    except Exception as e:
        print(f'An error has occured:{e}')
        raise Exception


def download_files(links_files: tuple, destination_folder: str):

    try:

        os.makedirs(destination_folder, exist_ok=True)

        for i, link in enumerate(links_files):
            path = os.path.join(
                destination_folder, f'anexo_{i + 1}.pdf')
            response = requests.get(link, stream=True)

            if response.status_code == 200:
                total_size = int(response.headers.get('content-length', 0))

                with open(path, 'wb') as file:
                    with tqdm(total=total_size, unit='B', unit_scale=True) as pbar:
                        for chunk in response.iter_content(chunk_size=1024):
                            if chunk:
                                file.write(chunk)
                                pbar.update(len(chunk))
                print(f'File saved in {path}')
    except Exception as e:
        print(f'An error has occured:{e}')
        raise Exception


def zip_files(origin, zip_file):
    with zipfile.ZipFile(zip_file, 'w') as zipf:
        for file in os.listdir(origin):
            if file.lower().endswith('.pdf'):
                full_path = os.path.join(origin, file)

                zipf.write(full_path, file)

                print(f'File {file} created')


if __name__ == '__main__':
    url = 'https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos'
    folder_pdfs = './1-TesteWebScrapping/pdf-files'

    files = access_site(url)

    download_files(files, folder_pdfs)

    zip_file = f'{folder_pdfs}/anexos.zip'

    zip_files(folder_pdfs, zip_file)
