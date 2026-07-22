




# Angular Front-End

Nachdem Sie Ihr openITCOCKPIT-Backend-Modul mithilfe des `bake`-Befehls erstellt sowie die Migration und ORM-Objekte generiert haben, ist es an der Zeit, das Front-End für das ExampleModule zu implementieren.

Diese Anleitung führt Sie durch die folgenden Schritte:

- Erstellen eines neuen Angular-Moduls
- Kommunikation mit der openITCOCKPIT-API
- Generieren der Komponente

Dieses Beispiel basiert auf dem [openITCOCKPIT ExampleModule Frontend Angular Repository](https://github.com/openITCOCKPIT/openITCOCKPIT-ExampleModule-Frontend-Angular), in dem Sie jederzeit das vollständige Modul herunterladen können.

## Ein neues Angular-Modul erstellen

Erstellen Sie zunächst Ihr eigenes Modulverzeichnis innerhalb des Angular-Projekts. Dieses Verzeichnis enthält Ihre Seiten, Komponenten, Services und Interfaces.

```bash
cd /opt/openitc/frontend-angular/src/app/modules/example_module
mkdir example_module
mkdir example_module/pages
```

### Die Komponente generieren

Sobald Ihr Service und Ihr Interface bereit sind, können Sie Ihre Seitenkomponente generieren. Diese Komponente verwendet den Service, um mit der openITCOCKPIT-API zu kommunizieren.

Die openITCOCKPIT-Entwickler empfehlen die folgende Verzeichnisstruktur:

```text
/opt/openitc/frontend-angular/src/app/modules/example_module/  <-- Your folder for everything
/opt/openitc/frontend-angular/src/app/modules/example_module/pages  <-- All pages are located here, but they are structured by
/opt/openitc/frontend-angular/src/app/modules/example_module/pages/test/  <-- The controller-name without "Controller"
/opt/openitc/frontend-angular/src/app/modules/example_module/pages/test/test-index/  <-- The exact controller-action combination.
```

Diese Konvention existiert aus einem wesentlichen Grund:

- Würde eine Komponente lediglich nach ihrer Aktion benannt werden (zum Beispiel `index`), hätten mehrere Komponenten denselben Namen.

Sie können Ihre Verzeichnisstruktur selbstverständlich anders organisieren, wenn dies besser zu Ihrem Projekt passt. Diese Anleitung orientiert sich jedoch an den empfohlenen openITCOCKPIT-Konventionen.

Nachdem Sie die benötigten Verzeichnisse mit `mkdir` erstellt haben, generieren Sie die erste Seitenkomponente.

```bash
cd /opt/openitc/frontend-angular/src/app/modules/example_module/pages/
ng generate component TestIndex
```

Nach Ausführung des Befehls finden Sie ein neues Verzeichnis mit den folgenden Dateien:

Dateien in `/opt/openitc/frontend-angular/src/app/modules/example_module/pages/test/test-index/`

```text
test-index.component.css
test-index.component.html
test-index.component.spec.ts
test-index.component.ts
```

Lassen Sie diese Dateien zunächst unverändert. Bevor wir die Komponente selbst implementieren, erstellen wir zuerst den Service und das Interface, die die Kommunikation mit der openITCOCKPIT-API übernehmen.

## Kommunikation mit der openITCOCKPIT-API

Als Nächstes ermöglichen wir unserer Komponente die Kommunikation mit der openITCOCKPIT-API. Dazu erstellen wir einen eigenen Angular-Service und ein entsprechendes Interface.

### Interface

Interfaces definieren die Struktur der API-Anfragen und -Antworten einschließlich aller übertragenen Daten. Da TypeScript objektorientierte Programmierung unterstützt, können Sie dasselbe Interface sowohl für Anfragen als auch für Antworten wiederverwenden, sofern beide dieselbe Struktur besitzen.

Das folgende Interface bildet die Struktur der Tabelle `Settings` ab.

Das Interface definiert die Felder, die von der API sowohl für GET- als auch für POST-Anfragen bereitgestellt und erwartet werden. Da die Datenstruktur in diesem Beispiel identisch ist, kann dasselbe Objekt sowohl zum Senden als auch zum Empfangen von Daten verwendet werden.

`/opt/openitc/frontend-angular/src/app/modules/example_module/test.interface.ts`.

```typescript
export interface TestGet {
    settings: TestSettings
    // _csrfToken: any  This is important, but it is not used from our service.
}

export interface TestPost {
    settings: TestSettings
}

// The actual object definition.
export interface TestSettings {
    id: number
    webhook_url: string
    created: string
    modified: string
}
```

### Service

Der Service ist für die Kommunikation mit der openITCOCKPIT-API verantwortlich. Er sendet Anfragen, verarbeitet Antworten und behandelt Fehler, die während der Kommunikation auftreten.

Generieren Sie zunächst den Service mit dem Befehl `ng generate`:

```bash
cd /opt/openitc/frontend-angular/src/app/modules/example_module
ng generate service test
```

Die generierte Service-Datei befindet sich unter `/opt/openitc/frontend-angular/src/app/modules/example_module/test.service.ts`.

Im aktuellen ExampleModule sieht der Service wie folgt aus:

```typescript
import { inject, Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { PROXY_PATH } from '../../tokens/proxy-path.token';
import { catchError, map, Observable, of } from 'rxjs';
import { GenericResponseWrapper, GenericSuccessResponse, GenericValidationError } from '../../generic-responses';
import { TestGet, TestSettings } from './test.interface';

@Injectable({
    providedIn: 'root'
})
export class TestService {

    private readonly http: HttpClient = inject(HttpClient);
    private readonly proxyPath: string = inject(PROXY_PATH);

    public getSettings(): Observable<TestSettings> {
        const proxyPath: string = this.proxyPath;
        return this.http.get<TestGet>(`${proxyPath}/example_module/test/index.json`, {
            params: {
                angular: true
            }
        }).pipe(
            map((data: TestGet) => {
                return data.settings
            })
        )
    }

    public postSettings(data: TestSettings): Observable<GenericResponseWrapper> {
        const proxyPath: string = this.proxyPath;
        return this.http.post<GenericResponseWrapper>(`${proxyPath}/example_module/test/index.json?angular=true`, data).pipe(
            map(data => {
                // Return true on 200 Ok
                return {
                    success: true,
                    data: {success: true} as GenericSuccessResponse
                };
            }),
            catchError((error: any) => {
                const err = error.error.error as GenericValidationError;
                return of({
                    success: false,
                    data: err
                });
            })
        );
    }
}
```

## Die Seitenkomponente zum Leben erwecken

Kehren wir nun zu der zuvor erstellten Front-End-Komponente zurück.

Das HTML-Template der Komponente definiert alles, was auf der Seite angezeigt wird. Da der Inhalt von den von openITCOCKPIT empfangenen Daten abhängt, wird das Template basierend auf den API-Antworten dynamisch aktualisiert.

Das HTML-Template sieht wie folgt aus:

```html
<!-- Hint from a fellow developer:
  - Notice, that we use the transloco directive to translate texts on the template.
  - This is our preferred way to translate texts in templates.
-->
<ng-container *transloco="let t">
    <nav aria-label="breadcrumb" class="mt-3">
        <ol class="breadcrumb">
            <li class="breadcrumb-item">
                <a [routerLink]="['/']">
                    <fa-icon [icon]="['fas', 'home']"></fa-icon>
                    <!-- Hint from a fellow developer:
                      - See that we use the t('string') function to translate the texts.
                    -->
                    {{ t('Home') }}
                </a></li>
            <li class="breadcrumb-item">
                <fa-icon [icon]="['fas', 'burn']"></fa-icon>
                {{ t('Example Module') }}
            </li>
            <li class="breadcrumb-item">
                <!-- Hint from a fellow developer:
                  - We add our own directive *oitcPermission here.
                  - If the user has the permission, the the object is an actual link. If not, it's just a text.
                -->
                <a [routerLink]="['/', 'example_module', 'test', 'index']"
                   *oitcPermission="['examplemodule', 'test', 'index']">
                    <fa-icon [icon]="['fas', 'cogs']"></fa-icon>
                    {{ t('Example Module') }}
                </a>
            </li>
            <li aria-current="page" class="breadcrumb-item active">
                <fa-icon [icon]="['fas', 'edit']"></fa-icon>
                {{ t('Hello World') }}
            </li>
        </ol>
    </nav>

    <!-- Hint from a fellow developer:
      - Note that this component is only shown as long as the response is not yet received.
      - This prevents flickering of the form as soon as data is received.
      - Note that we use [isVisible] here, which triggers fetching the dynamic page title on change.
    -->
    <oitc-form-loader [isVisible]="!post"></oitc-form-loader>

    <!-- Hint from a fellow developer:
      - This is the opposite of the above.
      - The form initially shows up as soon as our service received the data.
    -->
    <form cForm (ngSubmit)="submit()" *ngIf="post">
        <c-card class="mb-3">
            <c-card-header>
                <h5 cCardTitle>
                    {{ t('Example Module') }}
                    <small class="fw-300">
                        {{ t('Hello World') }}
                    </small>
                </h5>
            </c-card-header>
            <c-card-body>

                <div class="row">
                    <div class="col-12">

                        <div class="mb-3">
                            <label cLabel for="post.webhook_url">
                                {{ t('Webhook URL') }}
                                <oitc-required-icon></oitc-required-icon>
                            </label>

                            <!-- Hint from a fellow developer:
                              - Check that the input uses the cFormControl directive to make it look similar to the other inputs in openITCOCKPIT.
                              - The oitcFormError directive with parameters [errors] and errorField activate error handling on the field.
                            -->
                            <input cFormControl required
                                   [(ngModel)]="post.webhook_url"
                                   id="post.webhook_url"
                                   name="post.webhook_url"
                                   placeholder="https://mysite.office365.com/myteam-id/channel/mychannel-id/"
                                   type="text"
                                   oitcFormError [errors]="errors" errorField="webhook_url">

                            <!-- Hint from a fellow developer:
                              - This element will not be shown if there are no errors.
                            -->
                            <oitc-form-feedback [errors]="errors" errorField="webhook_url"></oitc-form-feedback>
                        </div>
                    </div>
                </div>
            </c-card-body>
            <c-card-footer class="text-end">
                <button cButton class="ripple" color="primary" type="submit">
                    {{ t('Save configuration') }}
                </button>
            </c-card-footer>
        </c-card>
    </form>
</ng-container>
```

Zusammen mit dem HTML-Template hat der Befehl `ng generate` auch die zugehörige TypeScript-Komponentendatei `test-index.component.ts` erstellt.

Das ExampleModule-Repository enthält die folgende Implementierung:

```typescript
import { ChangeDetectionStrategy, ChangeDetectorRef, Component, inject, OnDestroy, OnInit } from '@angular/core';
import { Subscription } from 'rxjs';
import { NotyService } from '../../../../../layouts/coreui/noty.service';
import { TestService } from '../../../test.service';
import { GenericValidationError } from '../../../../../generic-responses';
import { TestSettings } from '../../../test.interface';
import {
    CardBodyComponent,
    CardComponent,
    CardFooterComponent,
    CardHeaderComponent,
    CardTitleDirective,
    FormControlDirective,
    FormDirective,
    FormLabelDirective
} from '@coreui/angular';
import { FaIconComponent } from '@fortawesome/angular-fontawesome';
import { FormErrorDirective } from '../../../../../layouts/coreui/form-error.directive';
import { FormFeedbackComponent } from '../../../../../layouts/coreui/form-feedback/form-feedback.component';
import { FormLoaderComponent } from '../../../../../layouts/primeng/loading/form-loader/form-loader.component';
import { FormsModule } from '@angular/forms';
import { NgIf } from '@angular/common';
import { PermissionDirective } from '../../../../../permissions/permission.directive';
import { RequiredIconComponent } from '../../../../../components/required-icon/required-icon.component';
import { TranslocoDirective } from '@jsverse/transloco';
import { XsButtonDirective } from '../../../../../layouts/coreui/xsbutton-directive/xsbutton.directive';
import { RouterLink } from '@angular/router';

@Component({
    selector: 'oitc-test-index',
    imports: [
        CardBodyComponent,
        CardComponent,
        CardFooterComponent,
        CardHeaderComponent,
        CardTitleDirective,
        FaIconComponent,
        FormControlDirective,
        FormDirective,
        FormErrorDirective,
        FormFeedbackComponent,
        FormLabelDirective,
        FormLoaderComponent,
        FormsModule,
        NgIf,
        PermissionDirective,
        RequiredIconComponent,
        TranslocoDirective,
        XsButtonDirective,
        RouterLink
    ],
    templateUrl: './test-index.component.html',
    styleUrl: './test-index.component.css',
    /* Hint from a fellow developer:
     * - Note that we are using the ChangeDetectionStrategy.OnPush strategy.
     * - This means that the component will only be checked for changes when told to do so using markForCheck().
     * - This is a performance optimization technique in Angular that has effect on the browser.
     */
    changeDetection: ChangeDetectionStrategy.OnPush
})
export class TestIndexComponent implements OnInit, OnDestroy {
    private readonly Subscriptions: Subscription = new Subscription();
    private readonly TestService: TestService = inject(TestService);
    private readonly NotyService: NotyService = inject(NotyService);
    private readonly cdr: ChangeDetectorRef = inject(ChangeDetectorRef);

    /* Hint from a fellow developer:
     * - Note that post may be undefined.
     * - ngOnInit will fetch the settings from the API and put it here.
     */
    protected post?: TestSettings;

    /* Hint from a fellow developer:
     * - Note that errors may be undefined.
     */
    protected errors?: GenericValidationError;

    /* Hint from a fellow developer:
     * - Note that the Component implements both OnInit and OnDestroy interfaces.
     * - This is a common pattern in Angular components to manage subscriptions and lifecycle hooks.
     *
     * - We use them to fetch data when the component is initialized and clean up resources when the component is destroyed.
     */
    public ngOnInit(): void {
        this.Subscriptions.add(
            this.TestService.getSettings().subscribe((data: TestSettings) => {
                this.post = data;

                /* Hint from a fellow developer:
                 * - Note that we are triggering the ChangeDetection manually update the view.
                 * - Otherwise the user would not see the changes to the form.
                 */
                this.cdr.markForCheck();
            })
        );
    }

    /* Hint from a fellow developer:
     * - This cleans up the subscriptions when the component is destroyed.
     * - Otherwise the subscriptions would remain active and could lead to memory leaks.
     */
    public ngOnDestroy(): void {
        this.Subscriptions.unsubscribe();
    }

    /* Hint from a fellow developer:
     * - This method is called when the form is submitted.
     * - It checks if the post object is defined and then calls the TestService to submit the settings.
     * - If the submission is successful, it shows a success notification.
     * - If there are validation errors, it sets the errors property.
     *
     * - Error display in the form is handled by the oitcFormError directive.
     */
    protected submit(): void {
        if (!this.post) {
            return;
        }

        this.Subscriptions.add(
            this.TestService.postSettings(this.post).subscribe((response) => {
                this.errors = undefined;
                if (response.success) {
                    this.NotyService.genericSuccess();
                } else {
                    this.errors = response.data as GenericValidationError;
                    this.NotyService.genericError();
                }

                /* Hint from a fellow developer:
                 * - Note that we are triggering the ChangeDetection manually update the view.
                 * - Otherwise the user would not see the changes to the form and validation.
                 */
                this.cdr.markForCheck();
            })
        );
    }
}
```

## Routen hinzufügen

Die Seite selbst ist nun vollständig, aber Angular muss noch wissen, wie sie erreichbar ist.

Erstellen Sie eine eigene Routenkonfiguration unter:

`src/app/modules/example_module/example_module.routes.ts`

```typescript
import { Routes } from '@angular/router';

export const exampleModuleRoutes: Routes = [
    {
        path: 'example_module/test/index',
        loadComponent: () => import('./pages/test/test-index/test-index.component').then(m => m.TestIndexComponent)
    }
];
```

Registrieren Sie abschließend die neue Routenkonfiguration in der zentralen Routing-Konfiguration des openITCOCKPIT-Angular-Frontends:

`src/app/app.routes.ts`

```typescript
// ...
import { exampleModuleRoutes } from './modules/example_module/example_module.routes';

// ...
const moduleRoutes: Routes = [
    // other module routes
    ...exampleModuleRoutes,
];
```

Nach Abschluss dieser Schritte sollten Sie Ihre Seite innerhalb Ihrer openITCOCKPIT-Instanz unter `example_module/test/index` aufrufen können.